#include <iostream>
#include <fstream>
#include <types.h>
#include <malloc.h>
#include <sysinfoapi.h>
#include "ftd2xx.h"

#define MS_DEV_TYPE     8
#define MS_DEV_VID      0x0403
#define MS_DEV_PID      0x75D8
#define MS_DEV_ID       ((MS_DEV_VID <<16) | MS_DEV_PID)

#define SEND_SIZE       524288
#define GET_SIZE        524288

using namespace std;

int main()
{
    cout << "Hello World!" << endl;

    FT_HANDLE ftHandle;
    FT_STATUS ftStatus;
    FT_DEVICE_LIST_INFO_NODE* ftDevInfo;
    unsigned long dcount;
    unsigned char mask=0xff, mode=0x0, latency=16;

    ftStatus = FT_CreateDeviceInfoList(&dcount);
    ftDevInfo = (FT_DEVICE_LIST_INFO_NODE*)malloc(sizeof(FT_DEVICE_LIST_INFO_NODE)*dcount);
    FT_GetDeviceInfoList(ftDevInfo, &dcount);

    for(int i=0; i<dcount; i++) {
        if((ftDevInfo[i].Type == MS_DEV_TYPE) && (ftDevInfo[i].ID == MS_DEV_ID)) {
//            printf("Open device\n");
            cout << "Open device" << endl;
            ftStatus = FT_Open (i, &ftHandle);
            if (!FT_SUCCESS(ftStatus))
            {
//                printf("Unable to open USB device\n");
                cout << "Unable to open USB device" << endl;
                return 0;
            }
            break;
        }
    }
    if(ftHandle == NULL) {
//        printf("No device found\n");
        cout << "No device found" << endl;
        return 0;
    }

    mode = 0x0; //reset mode
    ftStatus = FT_SetBitMode(ftHandle, mask, mode);
    Sleep(1000);
    mode = 0x40;
    ftStatus = FT_SetBitMode(ftHandle, mask, mode);
    if(ftStatus != FT_OK) {
        printf("Set bit mode error %d\n", ftStatus);
        return -2;
    }
    FT_SetLatencyTimer(ftHandle, 2);
    FT_SetUSBParameters(ftHandle, 0x10000, 0x10000);
    FT_SetFlowControl(ftHandle, FT_FLOW_RTS_CTS, 0x0, 0x0);
    FT_Purge(ftHandle, /*FT_PURGE_RX |*/ FT_PURGE_TX);

    uint8_t rxbuff[524288];
    uint32_t rxbuffCount = 0;
    uint8_t txbuff[40000];

    for(int i=0; i<sizeof(txbuff); i++)
        txbuff[i] = i & 0xFF;

    unsigned long getSize, sendSize;
    unsigned long event, rxCount, txCount;
    unsigned long bytesWrite, bytesRead;

    unsigned long start, last, current, prev;

    getSize = 0;
    sendSize = 0;
    event = 0;
    rxCount = 0;
    txCount = 0;
    bytesWrite = 0;
    bytesRead = 0;

    ofstream rxfile;
    rxfile.open("e:\\rxlog.txt", ios_base::out | ios_base::binary | ios_base::trunc);
    if(!rxfile.is_open()) {
        cout << "Cant open file" << endl;
        return -1;
    }

    start = GetTickCount();
    while((sendSize < SEND_SIZE) || (getSize < GET_SIZE)) {
        cout << getSize << " - " << sendSize << endl;
        if(FT_GetStatus(ftHandle, &rxCount, &txCount, &event) == FT_OK) {
            if(sendSize < SEND_SIZE) {
                if(FT_Write(ftHandle, txbuff, 4096, &bytesWrite) == FT_OK) {
                    cout << "Send OK " << bytesWrite << endl;
                    sendSize += bytesWrite;
                } else {
                    cout << "Write error " << endl;
//                    return -2;
                }
            }
//            if((getSize < GET_SIZE) || (rxCount > 0)) {
                if(rxCount) {
                    if (FT_Read (ftHandle, rxbuff, rxCount, &bytesRead) == FT_OK) {
                        if(bytesRead > 0) {
                            cout << "Read OK " << bytesRead << " " << txCount << endl;
                            getSize += bytesRead;
                            for(int i=0; i<bytesRead; i++)
                                rxfile << rxbuff[i];
                        }
                    } else {
                        cout << "read error" << endl;
                    }
                }
//            }
        } else {
            cout << "get dstatus error" << endl;
        }

        current = GetTickCount();
        if((current - prev) >= 500) {
            prev = current;
            cout << "Alive " << getSize << "(" << rxCount << ")\t " << sendSize << "(" << txCount << ")" << endl;
            rxfile.flush();
        }
    }

    /*do {
        FT_GetStatus(ftHandle, &rxCount, &txCount, &event);
    } while(rxCount || txCount);*/

    cout << "Complete" << endl;
    FT_GetStatus(ftHandle, &rxCount, &txCount, &event);
     cout << "Alive " << getSize << "(" << rxCount << ")\t " << sendSize << "(" << txCount << ")" << endl;
    last = GetTickCount();

    double kbsec = (double) ((double) (getSize + sendSize) / 1000) / ((double) (last - start) / 1000);
    int timepassed = (last - start) / 1000;

    printf("Time:%d Size:%dB\/%dB Rate:%.1fKB/s       \r", timepassed, getSize, sendSize, kbsec);
//    cout << "Time: " << timepassed << "\t Get size: " << getSize << "\t Send size: " << sendSize << "\t Rate: " << kbsec << endl;

    rxfile.close();

    FT_SetBitMode(ftHandle, 0, 0);
    FT_Close(ftHandle);

    return 0;
}

