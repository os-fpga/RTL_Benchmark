#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <cmath>
#include <limits>
#include <chrono>
#include <unistd.h>

#include "ftd2xx.h"


using namespace std;


const int DEV_TYPE = 8;
const int DEV_VID = 0x0403;
const int DEV_PID = 0x75D8;
const int DEV_ID = (DEV_VID << 16) | DEV_PID;

const int BUFFER_SIZE = 524288;
const int MAX_TRANSACTION_SIZE = 65536 * 2;


enum TestMode {
    TM_READ = 1,
    TM_ECHO
};


FT_HANDLE ftHandle = 0;
FT_STATUS ftStatus = 0;

vector<int> devList;

uint8_t rxBuffer[BUFFER_SIZE] = {0};
uint8_t txBuffer[BUFFER_SIZE] = {0};
int txBufferHead = 0;
int rxBufferTail = 0;

DWORD readedBytesCount = 0;
DWORD writtenBytesCount = 0;
DWORD lastPortionSize = 0;
int errorsCount = 0;

DWORD targetSize = 524288 * 100;//262144;//524288;
int iterationCount = 5;

//DWORD startTime = 0, currentTime = 0, prevTime = 0;
double maxSpeed = 0, avgSpeed = 0, currentSpeed = 0;
double minSpeed = std::numeric_limits<DWORD>::max();

chrono::steady_clock::time_point timeBegin, timeCurrent, timePrev;


vector<int> errorsVector;



inline
void findDevice()
{
#ifdef linux
    ftStatus = FT_SetVIDPID(0x0403, 0x75d8);
#endif
    DWORD devCount = 0;
    devList.clear();
    ftStatus = FT_CreateDeviceInfoList(&devCount);
    if (!devCount)
        return;
    FT_DEVICE_LIST_INFO_NODE *ftDevInfo =
            (FT_DEVICE_LIST_INFO_NODE*)malloc(sizeof(FT_DEVICE_LIST_INFO_NODE)*devCount);
    FT_GetDeviceInfoList(ftDevInfo, &devCount);
    for (uint32_t i = 0; i < devCount; ++i) {
        if (ftDevInfo[i].ID == DEV_ID) {
            devList.push_back(i);
            cout << "Dev flags: " << ftDevInfo[i].Flags << endl;
        }
    }
    free(ftDevInfo);
}

inline
bool openDevice(int index)
{
    ftStatus = FT_Open(index, &ftHandle);
    if (!FT_SUCCESS(ftStatus)) {
        cout << "Unable to open USB device. " << ftStatus << endl;
        return false;
    }
    if (ftHandle == NULL) {
        cout << "No device found" << endl;
        return false;
    }
    //configure
    uint8_t mask=0xff, mode=0x0, latency=2;
    mode = 0x0; //reset mode
    ftStatus = FT_SetBitMode(ftHandle, mask, mode);
    usleep(1000000);
    mode = 0x40;
    ftStatus = FT_SetBitMode(ftHandle, mask, mode);
    if (!FT_SUCCESS(ftStatus)) {
        cout << "Set bit mode failed. " << ftStatus << endl;
        return false;
    }
    FT_SetLatencyTimer(ftHandle, latency);
    FT_SetUSBParameters(ftHandle, 0x10000, 0x10000);
    FT_SetFlowControl(ftHandle, FT_FLOW_RTS_CTS, 0x0, 0x0);
    FT_Purge(ftHandle, FT_PURGE_RX | FT_PURGE_TX);
    return true;
}

inline
void closeDevice()
{
    FT_Close(ftHandle);
}


inline
DWORD availableData()
{
    DWORD queue;
    ftStatus = FT_GetQueueStatus(ftHandle, &queue);
    if (!FT_SUCCESS(ftStatus)) {
        cout << "Get available data failed. " << ftStatus << endl;
        return 0;
    }
    return queue;
}

inline
bool readData(void *buffer, DWORD size, DWORD &bytesReaded)
{
    ftStatus = FT_Read(ftHandle, buffer, size, &bytesReaded);
    if (!FT_SUCCESS(ftStatus)) {
        cout << "Read data failed. " << ftStatus << endl;
        return false;
    }
    return true;
}

inline
bool writeData(void *data, DWORD size, DWORD &bytesWritten)
{
    ftStatus = FT_Write(ftHandle, data, size, &bytesWritten);
    if (!FT_SUCCESS(ftStatus)) {
        cout << "Write data failed. " << ftStatus << endl;
        return false;
    }
    return true;
}


void calcSpeed(bool force = false)
{
    timeCurrent = chrono::steady_clock::now();
    double time = chrono::duration_cast<chrono::milliseconds>(timeCurrent - timePrev).count();
    if (( time >= 500 ) || force) {
        double dataSize = lastPortionSize * 1.0 / 1000;
        time /= 1000;
        currentSpeed = dataSize / time;
        dataSize = (readedBytesCount + writtenBytesCount) * 1.0 / 1000;
        time = chrono::duration_cast<chrono::milliseconds>(timeCurrent - timeBegin).count();
        time /= 1000;
        avgSpeed = dataSize / time;
        if (currentSpeed > maxSpeed)
            maxSpeed = currentSpeed;
        if (currentSpeed < minSpeed)
            minSpeed = currentSpeed;
        timePrev = timeCurrent;
        lastPortionSize = 0;

        cout << "Time: " << floor(time) << " Size(w/r): " << fixed << setprecision(3)
             << writtenBytesCount * 1.0 / 1000 << "/"
             << readedBytesCount * 1.0 / 1000 << defaultfloat
             << " kB \tRate (min/max/avg/current): " << int(floor(minSpeed)) << "/"
             << int(floor(maxSpeed)) << "/" << int(floor(avgSpeed)) << "/"
             << int(floor(currentSpeed)) << " kB/s \tErrors: " << errorsCount << endl;
        flush(cout);
    }
}

inline
void checkData(int offset, int size)
{
    for (int i = offset; (i < BUFFER_SIZE) && (i < offset + size); ++i) {
        if (rxBuffer[i] != txBuffer[i]) {
            if (errorsCount == 0) {
                int pi = i - 1;
                if (pi < 0)
                    pi = targetSize - 1;
                while (pi > BUFFER_SIZE) {
                    pi -= BUFFER_SIZE;
                }
                int ni = i + 1;
                if (ni >= BUFFER_SIZE)
                    ni = 0;

                cout << i << " " << int(txBuffer[i]) << " - " << int(rxBuffer[i])
                     << " \t" << pi << " " << int(txBuffer[pi]) << " - "
                     << int(rxBuffer[pi]) << " \t" << ni << " "
                     << int(txBuffer[ni]) << " I: ";

                /*for (int j = 0; (j < targetSize) && (j < BUFFER_SIZE); ++j) {
                    if (txBuffer[j] == rxBuffer[i]) {
//                        cout << j << " ";
                        auto fit = find(begin(errorsVector), end(errorsVector), j);
                        if ( fit != errorsVector.end()) {
                            cout << j << " ";
                        }
                    }
                }*/
                cout << endl;
            }
            ++errorsCount;
        }
    }
}


inline
void readMode()
{
    DWORD available = 0;
    DWORD bytesRead = 0;
    uint8_t value = 0;

    readedBytesCount = 0;
    writtenBytesCount = 0;
    lastPortionSize = 0;
    txBufferHead = 0;
    rxBufferTail = 0;
    errorsCount = 0;
    maxSpeed = 0;
    minSpeed = std::numeric_limits<DWORD>::max();
    avgSpeed = 0;
    currentSpeed = 0;

    txBuffer[0] = TM_READ;
    if (!writeData(txBuffer, 1, bytesRead)) {
        return;
    }
    timePrev = timeCurrent = timeBegin = chrono::steady_clock::now();
    while (true) {
        available = availableData();
        if (!available)
            continue;
        if (available > BUFFER_SIZE)
            available = BUFFER_SIZE;
        if (!readData(rxBuffer, available, bytesRead)) {
            return;
        }
        if (!bytesRead)
            continue;
        if (!readedBytesCount) {
            value = rxBuffer[0];
        }
        for (DWORD i = 0; i < bytesRead; ++i) {
            if (value != rxBuffer[i]) {
                ++errorsCount;
                value = rxBuffer[i];
            }
            ++value &= 0xFF;
        }
        readedBytesCount += bytesRead;
        lastPortionSize += bytesRead;

        calcSpeed();
    }
}

inline
void echoMode()
{
    DWORD available = 0;
    DWORD bytesRead = 0;
    DWORD bytesWrite = 0;
    DWORD writeSize = 0;

    readedBytesCount = 0;
    writtenBytesCount = 0;
    lastPortionSize = 0;
    txBufferHead = 0;
    rxBufferTail = 0;
    errorsCount = 0;
    maxSpeed = 0;
    minSpeed = std::numeric_limits<DWORD>::max();
    avgSpeed = 0;
    currentSpeed = 0;

    uint8_t mode = TM_ECHO;
    /*if (!writeData(&mode, 1, bytesRead)) {
        return;
    }
    if (!writeData(&targetSize, 4, bytesRead)) {
        return;
    }*/

//    prevTime = currentTime = startTime = GetTickCount();
    timePrev = timeCurrent = timeBegin = chrono::steady_clock::now();

    cout << "Start loop" << endl;
    while ((writtenBytesCount < targetSize) || (readedBytesCount < targetSize)) {
        // send
        if ((writtenBytesCount < targetSize)
                && ((writtenBytesCount - readedBytesCount) < MAX_TRANSACTION_SIZE)) {
            writeSize = BUFFER_SIZE - txBufferHead;
            if (writeSize > (targetSize - writtenBytesCount))
                writeSize = targetSize - writtenBytesCount;
            if (writeSize > MAX_TRANSACTION_SIZE)
                writeSize = MAX_TRANSACTION_SIZE;
            if (!writeData(&txBuffer[txBufferHead], writeSize, bytesWrite)) {
                return;
            }
//            cout << "write " << txBufferHead << " " << int(txBuffer[txBufferHead])
//                 << " " << bytesWrite << endl;
            writtenBytesCount += bytesWrite;
            lastPortionSize += bytesWrite;
            txBufferHead += bytesWrite;
            if (txBufferHead == BUFFER_SIZE) {
                txBufferHead = 0;
            }
            else if (txBufferHead > BUFFER_SIZE) {
                cout << "Tx buffer range error" << endl;
                return;
            }
        }

        // read
        available = availableData();
        if ((readedBytesCount < targetSize) && available) {
            if (available > (BUFFER_SIZE - rxBufferTail))
                available = BUFFER_SIZE - rxBufferTail;
            if (available > (targetSize - readedBytesCount)) {
                cout << "More data then need " << available << "/"
                     << targetSize - readedBytesCount << endl;
                available = targetSize - readedBytesCount;
            }
            if (!readData(&rxBuffer[rxBufferTail], available, bytesRead)) {
                return;
            }
//            cout << "read " << rxBufferTail << " " << bytesRead
//                 << " " << rxBufferTail + bytesRead << endl;
            readedBytesCount += bytesRead;
            lastPortionSize += bytesRead;
            checkData(rxBufferTail, bytesRead);
            rxBufferTail += bytesRead;
            if (rxBufferTail == BUFFER_SIZE) {
                rxBufferTail = 0;
            }
            else if (rxBufferTail > BUFFER_SIZE) {
                cout << "Rx buffer range error" << endl;
                return;
            }
        }

        calcSpeed();
    }
    calcSpeed(true);
    cout << endl << availableData() << endl;
}


int main(int argc, char *argv[])
{
    cout << "Hello World!" << endl;

    for (int i = 0; i < BUFFER_SIZE; ++i) {
        txBuffer[i] = rand() & 0xFF;
        if (txBuffer[i] == 94) {
            errorsVector.push_back(i);
            --i;
        }
    }

    findDevice();
    cout << devList.size() << " devices found" << endl;
    if (!devList.size())
        return 0;
    DWORD index;
    cout << "Put device index (from 0 to devices count): ";
    cin >> index;
    cout << endl;
    if (index >= devList.size()) {
        cout << "You fool!" << endl;
        return 0;
    }
    cout << "Open device " << index << " ... ";
    if (!openDevice(index)) {
        cout << "[FAIL]" << endl;
        return 0;
    }
    cout << "[ OK ]" << endl;

    cout << "Select mode:\n\t" << TM_READ << " - read\n\t"
         << TM_ECHO << " - echo\n\t* - exit" << endl;
    cout<< "Enter your choice: ";
    cin >> index;
    cout << endl;
    switch (index) {
    case TM_READ:
        cout << "Start read mode" << endl;
        readMode();
        break;
    case TM_ECHO:
        cout << "Start echo mode" << endl;
        while (iterationCount-- && (errorsCount == 0)) {
            echoMode();
//            cout << "Data:" << endl;
//            for (int i = 0; i < targetSize; ++i) {
//                cout << int(txBuffer[i]) << " = " << int(rxBuffer[i]) << endl;
//            }
//            ++targetSize;
        }
        break;
    default:
        break;
    }

    closeDevice();
    cout << "Finish" << endl;
    return 0;
}
