package webexponentiator.util;

import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

public class Communication implements SerialPortDataListener {

	protected final Log logger = LogFactory.getLog(getClass());

	String selectedPort = "COM3";
	
	// just a boolean flag that i use for enabling
	// and disabling buttons depending on whether the program
	// is connected to a serial port or not
	private boolean bConnected = false;

	// the timeout value for connecting with the port
	final static int TIMEOUT = 2000;

	// for containing the ports that will be found
	private SerialPort[] ports = null;
	// map the port names to CommPortIdentifiers
	private HashMap<String, SerialPort> portMap = new HashMap<String, SerialPort>();

	// this is the object that contains the opened port
	private SerialPort serialPort = null;

	// input and output streams for sending and receiving data
	private InputStream input = null;
	private OutputStream output = null;

	public Communication() {

	}

	// a string for recording what goes on in the program
	// this string is written to the GUI
	String logText = "";

	// search for all the serial ports
	// pre style="font-size: 11px;": none
	// post: adds all the found ports to a combo box on the GUI
	public ArrayList<String> searchForPorts() {

		ArrayList<String> result = new ArrayList<String>();

		ports = SerialPort.getCommPorts();
		logger.info("COM ports identified");

		for (SerialPort port:ports) {
			String portName = port.getDescriptivePortName();
			if (portName.contains("COM3")) {
				selectedPort = portName;
			}
			// get only serial ports
			result.add(portName);
			portMap.put(portName, port);
		}

		return result;
	}

	public String connect() {
		serialPort = (SerialPort) portMap.get(selectedPort);
		serialPort.setBaudRate(115200);
		serialPort.setNumDataBits(8);
		serialPort.setNumStopBits(1);
		serialPort.setParity(SerialPort.ODD_PARITY);

			// the method below returns an object of type CommPort
			setConnected(serialPort.openPort());

			// for controlling GUI elements

			// logging
			logger.info(selectedPort + " opened successfully.");

			return "COM3 connected ok";
	}

	public boolean initIOStream() {
		// return value for whether opening the streams is successful or not
		boolean successful = false;

			input = serialPort.getInputStream();
			output = serialPort.getOutputStream();

			successful = true;
			return successful;

	}

	public void initListener() {
			serialPort.addDataListener(this);
	}

	public void disconnect() {
		// close the serial port
		try {
			serialPort.removeDataListener();
			input.close();
			output.close();
			serialPort.closePort();
			setConnected(false);

			logger.info("Disconnected.");
		} catch (Exception e) {
			logger.error("Failed to close " + serialPort.getDescriptivePortName() + "("
					+ e.toString() + ")");
		}
	}
	
	public String readData() {
		try {
			byte[] buffer = new byte[65];
			int n = input.read(buffer);
			if (n > 0) {
				if (n == 1) {
					BigInteger command = new BigInteger(new byte[] { 0,
							buffer[0] });
					String s = "Command = " + command.toString(16);
					return s;
				} else {
					buffer = ArrayUtils.subarray(buffer, 0, buffer.length - 1);
            		buffer = ArrayUtils.add(buffer, (byte)0);
            		ArrayUtils.reverse(buffer);
            		BigInteger data = new BigInteger(buffer);
					return data.toString(16);
				}
			}
		} catch (Exception e) {
			logger.error("Failed to read data. (" + e.toString() + ")");
		}
		return null;
	}

	@Override
	public int getListeningEvents() {
		return SerialPort.LISTENING_EVENT_DATA_AVAILABLE;
	}
	
	@Override
	public void serialEvent(SerialPortEvent evt) {
		if (evt.getEventType() != SerialPort.LISTENING_EVENT_DATA_AVAILABLE) {
			try {
				byte[] buffer = new byte[10];
				int n = input.read(buffer);
				if (n > 0) {
					if (n == 1) {
						BigInteger command = new BigInteger(new byte[] { 0,
								buffer[0] });
						final String s = "Command = " + command.toString(16)
								+ "\n";
						//TODO Something for retrieve data
						//window.appendText(s);
					} else {
						ArrayUtils.reverse(buffer);
						BigInteger data = new BigInteger(buffer);
						//TODO Something for retrieve data
						//window.appendText(data.toString(10) + "\n");
					}
				}
			} catch (Exception e) {
				logger.error("Failed to read data. (" + e.toString() + ")");
			}
		}
	}

	public void writeByte(byte b) {
		try {
			output.write(b);
			Thread.sleep(1);
		} catch (Exception e) {
			logger.error("Failed to write data. (" + e.toString() + ")");
		}		
	}
	
	// method that can be called to send data
	// pre style="font-size: 11px;": open serial port
	// post: data sent to the other device
	public void writeData(String str) {
		try {
			BigInteger bi = new BigInteger(str, 2);
			byte[] b = bi.toByteArray();
			if (b.length == 2) {
				output.write(b[1]);
			} else {
				output.write(b);
			}
			Thread.sleep(1);
		} catch (Exception e) {
			logger.error("Failed to write data. (" + e.toString() + ")");
		}
	}

	final public boolean getConnected() {
		return bConnected;
	}

	private void setConnected(boolean bConnected) {
		this.bConnected = bConnected;
	}

}
