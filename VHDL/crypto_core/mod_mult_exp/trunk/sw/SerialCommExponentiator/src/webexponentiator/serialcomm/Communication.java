package webexponentiator.serialcomm;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;

import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.util.HashMap;

import org.apache.commons.lang3.ArrayUtils;
import org.eclipse.swt.graphics.Color;

public class Communication implements SerialPortDataListener {
	
	//passed from main GUI
    Window window = null;
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

	public Communication(Window window) {
		this.window = window;
	}

	// a string for recording what goes on in the program
	// this string is written to the GUI
	String logText = "";
	
	// search for all the serial ports
	// pre style="font-size: 11px;": none
	// post: adds all the found ports to a combo box on the GUI
	public void searchForPorts() {

		ports = SerialPort.getCommPorts();

		for (SerialPort port:ports) {
			String portName = port.getDescriptivePortName();
			if (portName.contains("COM3")) {
				selectedPort = portName;
			}
			// get only serial ports
			window.combo.add(portName);
			portMap.put(portName, port);
		}
	}

	// connect to the selected port in the combo box
	// pre style="font-size: 11px;": ports are already found by using the
	// searchForPorts
	// method
	// post: the connected comm port is stored in commPort, otherwise,
	// an exception is generated
	public void connect() {
		if (window.combo.getSelectionIndex() >= 0) {
			selectedPort = (String) window.combo.getItem(window.combo.getSelectionIndex());
			serialPort = (SerialPort) portMap.get(selectedPort);
			serialPort.setBaudRate(115200);
			serialPort.setNumDataBits(8);
			serialPort.setNumStopBits(1);
			serialPort.setParity(SerialPort.ODD_PARITY);

				// the method below returns an object of type CommPort
				setConnected(serialPort.openPort());
				if (getConnected()) {
					// logging
					logText = selectedPort + " opened successfully.";
					window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 0, 0, 0));
					window.appendText(logText + "\n");
					window.toggleControls();
				} else {
					logText = selectedPort + " was not opened";
					window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 255, 0, 0));
					window.appendText(logText + "\n");
				}
		}
	}
	// open the input and output streams
	// pre style="font-size: 11px;": an open port
	// post: initialized input and output streams for use to communicate data
	public boolean initIOStream() {
		// return value for whether opening the streams is successful or not
		boolean successful = false;

		input = serialPort.getInputStream();
		output = serialPort.getOutputStream();

		successful = true;
		return successful;
	}

	// starts the event listener that knows whenever data is available to be
	// read
	// pre style="font-size: 11px;": an open serial port
	// post: an event listener for the serial port that knows when data is
	// received
	public void initListener() {
			serialPort.addDataListener(this);
	}

	//disconnect the serial port
    //pre style="font-size: 11px;": an open serial port
    //post: closed serial port
    public void disconnect()
    {
        //close the serial port
		try {
			serialPort.removeDataListener();
			input.close();
			output.close();
			serialPort.closePort();
			setConnected(false);
            window.toggleControls();

            logText = "Disconnected.";
            window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 255, 0, 0));
            window.appendText(logText + "\n");

			logText = "Disconnected.";
		} catch (Exception e) {
            logText = "Failed to close " + serialPort.getDescriptivePortName()
            + "(" + e.toString() + ")";
            window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 255, 0, 0));
			window.appendText(logText + "\n");
		}
    }


	@Override
	public int getListeningEvents() {
		return SerialPort.LISTENING_EVENT_DATA_AVAILABLE;
	}
	
    //what happens when data is received
    //pre style="font-size: 11px;": serial event is triggered
    //post: processing on the data it reads
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
//						buffer = ArrayUtils.subarray(buffer, 0, buffer.length - 2);
//                		buffer = ArrayUtils.add(buffer, (byte)0);
//                		ArrayUtils.reverse(buffer);
//                		BigInteger data = new BigInteger(buffer);
//                		window.appendText(data.toString(10) + "\n");
					}
					window.appendText("\n");
				}
			} catch (Exception e) {
                logText = "Failed to read data. (" + e.toString() + ")";
                window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 255, 0, 0));
                window.appendText(logText + "\n");
			}
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
			window.appendText("Failed to read data. (" + e.toString() + ")");
		}
		return null;
	}
	
    //method that can be called to send data
    //pre style="font-size: 11px;": open serial port
    //post: data sent to the other device
    public void writeData(String str)
    {
        try
        {
        	BigInteger bi = new BigInteger(str, 2);
        	byte [] b = bi.toByteArray();
        	if (b.length == 2) {
        		output.write(b[1]);
        	} else {
        		output.write(b);
        	}
        	Thread.sleep(50);
        	//ArrayUtils.reverse(b);
        	/*String [] data = str.split(" ");
        	byte [] b = new byte [data.length]; 
        	for (int i = 0; i < data.length; i++) {
        		Byte toSend = Byte.decode(data[i]);
        		b[i] = toSend;
        		
        	}
        	ArrayUtils.reverse(b);
        	for (int i = 0; i < b.length; i++) {
        		output.write(b[i]);
        		Thread.sleep(1);
        	}*/
        	//b = Arrays.copyOfRange(b, 1, b.length);
        	//ArrayUtils.reverse(b);
        	//for (int i = 0; i < b.length; i++) {
        	//	output.write(b[i]);
        	//	Thread.sleep(10);
        	//}
        	//output.flush();
        }
        catch (Exception e)
        {
            logText = "Failed to write data. (" + e.toString() + ")";
            window.text.setForeground(new Color(window.shlPcExponentiator.getDisplay(), 255, 0, 0));
            window.appendText(logText + "\n");
        }
    }

    final public boolean getConnected()
    {
        return bConnected;
    }

    public void setConnected(boolean bConnected)
    {
        this.bConnected = bConnected;
    }

	
}
