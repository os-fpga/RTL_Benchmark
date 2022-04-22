package webexponentiator.serialcomm;

import java.math.BigInteger;
import java.util.Date;
import java.util.Random;

import org.apache.commons.lang3.ArrayUtils;
import org.eclipse.swt.SWT;
import org.eclipse.swt.events.MouseAdapter;
import org.eclipse.swt.events.MouseEvent;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Combo;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.swt.widgets.Text;

import webexponentiator.serialcomm.Command;

import org.eclipse.swt.custom.CLabel;
import org.eclipse.swt.events.DisposeListener;
import org.eclipse.swt.events.DisposeEvent;
import org.eclipse.swt.graphics.Point;

public class Window {

	//Communicator object
    Communication communication = null;
	public Display display;
	protected Shell shlPcExponentiator;
	public Text text;
	private Text text_2;
	public Combo combo;
	private Button btnConnect;
	private Button btnDisconnect;
	private Button btnSendAutomated;
	private Button btnSendResult;
	private Button btnSendPrepare;
	private Button btnBase;
	private Button btnModulus;
	private Button btnExponent;
	private Button btnResiduum;
	private Button btnPowerMod;

	public void toggleControls()
    {
        if (communication.getConnected() == true)
        {
        	btnDisconnect.setEnabled(true);
            btnConnect.setEnabled(false);
            btnSendAutomated.setEnabled(true);
            btnSendResult.setEnabled(true);
            btnSendPrepare.setEnabled(true);
            btnBase.setEnabled(true);
            btnModulus.setEnabled(true);
            btnExponent.setEnabled(true);
            btnResiduum.setEnabled(true);
            btnPowerMod.setEnabled(true);
        }
        else
        {
        	btnDisconnect.setEnabled(false);
            btnConnect.setEnabled(true);
            btnSendAutomated.setEnabled(false);
            btnSendResult.setEnabled(false);
            btnSendPrepare.setEnabled(false);
            btnBase.setEnabled(false);
            btnModulus.setEnabled(false);
            btnExponent.setEnabled(false);
            btnResiduum.setEnabled(false);
            btnPowerMod.setEnabled(false);
        }
    }
    
	/**
	 * Launch the application.
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			Window window = new Window();
			window.open();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Open the window.
	 */
	public void open() {
		display = Display.getDefault();
		createContents();
		communication = new Communication(this);
		communication.searchForPorts();
		toggleControls();
		shlPcExponentiator.open();
		shlPcExponentiator.layout();
		while (!shlPcExponentiator.isDisposed()) {
			if (!display.readAndDispatch()) {
				display.sleep();
			}
		}
	}

	/**
	 * Create contents of the window.
	 */
	protected void createContents() {
		shlPcExponentiator = new Shell(SWT.CLOSE | SWT.MIN | SWT.TITLE);
		shlPcExponentiator.setSize(new Point(483, 369));
		shlPcExponentiator.addDisposeListener(new DisposeListener() {
			public void widgetDisposed(DisposeEvent arg0) {
				if (communication.getConnected()) {
					communication.disconnect();
				}
			}
		});
		shlPcExponentiator.setSize(493, 399);
		shlPcExponentiator.setText("PC Exponentiator");
		shlPcExponentiator.setLayout(null);

		Composite composite = new Composite(shlPcExponentiator, SWT.NONE);
		composite.setBounds(0, 0, 483, 369);

		text = new Text(composite, SWT.BORDER | SWT.WRAP | SWT.H_SCROLL | SWT.V_SCROLL | SWT.CANCEL | SWT.MULTI);
		this.text.setBounds(10, 171, 463, 188);

		combo = new Combo(composite, SWT.NONE);
		combo.setBounds(10, 10, 124, 23);

		btnConnect = new Button(composite, SWT.NONE);
		btnConnect.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				communication.connect();
		        if (communication.getConnected() == true)
		        {
		            if (communication.initIOStream() == true)
		            {
		            	communication.initListener();
		            }
		        }
			}
		});
		btnConnect.setBounds(140, 10, 75, 25);
		btnConnect.setText("Connect");

		btnDisconnect = new Button(composite, SWT.NONE);
		btnDisconnect.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				communication.disconnect();
			}
		});
		btnDisconnect.setBounds(221, 10, 75, 25);
		btnDisconnect.setText("Disconnect");

		Label lblLog = new Label(composite, SWT.NONE);
		lblLog.setBounds(10, 150, 55, 15);
		lblLog.setText("Log");

		btnSendAutomated = new Button(composite, SWT.NONE);
		btnSendAutomated.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
					Random r = new Random(new Date().getTime());
					BigInteger modulus = BigInteger.probablePrime(512, r);
					BigInteger base = new BigInteger(512, r).mod(modulus);
					BigInteger exponent = new BigInteger(512, r).mod(modulus);
					BigInteger residuum = new BigInteger("2").modPow(new BigInteger("1024"), modulus);
					BigInteger expectedResult = base.modPow(exponent, modulus);
					/*
					 * result.add(sendBase(
					 * "10831972010009692284864743082963908985928244572237504978567815597954452424901701848115907348099319027887255346705501542390228546770547307022309796259930536"
					 * )); result.add(sendModulus(
					 * "11639194216848075599002265489360912001411488135138961225285267565441921553320210324625995654671521634712013831000392536053201786146999373798311679376312847"
					 * )); result.add(sendExponent(
					 * "1164213079911476522452523716613118512153792329806743382289257300977572318091588414675225325908322428116294194315992613761814533537627230020523566408522775"
					 * )); result.add(sendResiduum(
					 * "1710026381007983649390259627245755642172838934666512596966326197048317423109472713444486555154343967450576033188072022772979735585191761951832684734601532"
					 * ));
					 */
					appendText("Send " + sendBase(base.toString(10)) + "\n");
					appendText("Send " + sendModulus(modulus.toString(10)) + "\n");
					appendText("Send " + sendExponent(exponent.toString(10)) + "\n");
					appendText("Send " + sendResiduum(residuum.toString(10)) + "\n");
					appendText(sendPower() + "\n");
					String result = sendResult();
					if (null != result) {
						appendText("Result = \n" + result + "\n");
					} else {
						appendText("Result is NULL!!! \n");
					}
					appendText("Send prepare\n" + sendPrepare() + "\n");
					appendText("Expected result " + expectedResult.toString(16) + "\n");
					if (expectedResult.toString(16).compareTo(result) == 0) {
						appendText("Expected result = calculated result");
					} else {
						appendText("Calculated result ERROR!\nExpected result is \n" + expectedResult + "\nCalculated result is\n" + result + "\n");
					}
						
					
//				for (int i = 0; i < dataProtocol.length; i++) {
//					String [] el = dataProtocol[i].split(" ");
//					ArrayUtils.reverse(el);
//					for (int j = 0; j < el.length; j++) {
//						communication.writeData(el[j]);
//					}
//				}
			}
		});
		btnSendAutomated.setBounds(256, 119, 91, 25);
		btnSendAutomated.setText("Send automated");

		text_2 = new Text(composite, SWT.BORDER);
		text_2.setBounds(10, 60, 463, 21);

		btnSendResult = new Button(composite, SWT.NONE);
		btnSendResult.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				String result = sendResult();
				if (null != result) {
					appendText("Result = " + result + "\n");
				} else {
					appendText("Result is NULL!!! \n");
				}
			}
		});
		btnSendResult.setBounds(91, 119, 75, 25);
		btnSendResult.setText("Send result");
		
		btnSendPrepare = new Button(composite, SWT.NONE);
		btnSendPrepare.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				appendText("Send prepare:\n" + sendPrepare() + "\n");
			}
		});
		btnSendPrepare.setBounds(172, 119, 75, 25);
		btnSendPrepare.setText("Send prepare");
		
		btnBase = new Button(composite, SWT.NONE);
		btnBase.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				String text = text_2.getText();
				try {
				BigInteger bi = new BigInteger(text, 10);
				appendText("Send base:\n" + sendBase(text) + "\n");
				} catch (NumberFormatException e) {
					appendText("Wrong number format to send base \n");
				}
			}
		});
		btnBase.setBounds(10, 85, 75, 25);
		btnBase.setText("Base");
		
		btnModulus = new Button(composite, SWT.NONE);
		btnModulus.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				String text = text_2.getText();
				try {
				BigInteger bi = new BigInteger(text, 10);
				appendText("Send modulus:\n" + sendModulus(text) + "\n");
				} catch (NumberFormatException e) {
					appendText("Wrong number format to send modulus");
				}
			}
		});
		btnModulus.setBounds(91, 85, 75, 25);
		btnModulus.setText("Modulus");
		
		btnExponent = new Button(composite, SWT.NONE);
		btnExponent.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				String text = text_2.getText();
				try {
				BigInteger bi = new BigInteger(text, 10);
				appendText("Send exponent:\n" + sendExponent(text) + "\n");
				} catch (NumberFormatException e) {
					appendText("Wrong number format to send exponent");
				}
			}
		});
		btnExponent.setBounds(172, 85, 75, 25);
		btnExponent.setText("Exponent");
		
		btnResiduum = new Button(composite, SWT.NONE);
		btnResiduum.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				String text = text_2.getText();
				try {
				BigInteger bi = new BigInteger(text, 10);
				appendText("Send residuum:\n" + sendResiduum(text) + "\n");
				} catch (NumberFormatException e) {
					appendText("Wrong number format to send residuum");
				}
			}
		});
		btnResiduum.setBounds(256, 85, 75, 25);
		btnResiduum.setText("Residuum");
		
		btnPowerMod = new Button(composite, SWT.NONE);
		btnPowerMod.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseUp(MouseEvent arg0) {
				appendText("Send power:\n" + sendPower() + "\n");
			}
		});
		btnPowerMod.setBounds(10, 119, 75, 25);
		btnPowerMod.setText("Power Mod");
		
		CLabel lblWriteHexadecimalValue = new CLabel(composite, SWT.NONE);
		lblWriteHexadecimalValue.setBottomMargin(1);
		lblWriteHexadecimalValue.setTopMargin(1);
		lblWriteHexadecimalValue.setBounds(10, 39, 172, 21);
		lblWriteHexadecimalValue.setText("Write DECIMAL value:");
	}
	
	private String sendPrepare() {
		sendData(new String[] { Command.mn_prepare_for_data });
		waitMicron("prepare");
		return "prepare";
	}

	private String sendResult() {
		sendData(new String[] { Command.mn_show_result});
		waitMicron("show result");
		return communication.readData();
	}

	private String sendPower() {
		sendData(new String[] { Command.mn_count_power });
		waitMicron("count power");
		return "count power \n" + communication.readData();
	}

	private String sendResiduum(String string) {
		String residuum = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_residuum, residuum };
		sendData(send);
		waitMicron("residuum");
		return "residuum - " + string + "\n" + communication.readData();
	}

	private String sendExponent(String string) {
		String exponent = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_exponent, exponent };
		sendData(send);
		waitMicron("exponent");
		return "exponent - " + string + "\n" + communication.readData();
	}

	private String sendModulus(String string) {
		String modulus = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_modulus, modulus };
		sendData(send);
		waitMicron("modulus");
		return "modulus - " + string + "\n" + communication.readData();
	}

	private String sendBase(String data) {
		String base = parseDataToSend(data, 10);
		String[] send = { Command.mn_read_base, base };
		sendData(send);
		waitMicron("base");
		return "base - " + data + "\n" + communication.readData();
	}

	
	private String parseDataToSend(String string, int radix) {
		BigInteger strBi = new BigInteger(string, radix);
		String result = new String("");
		for (int i = Command.MAX_WORD - 1; i >= strBi.bitLength(); i--) {
			result = result.concat("0");

			if (i % 8 == 0) {
				result = result.concat(" ");
			}
		}

		for (int i = strBi.bitLength() - 1; i >= 0; i--) {
			if (strBi.testBit(i)) {
				result = result.concat("1");
			} else {
				result = result.concat("0");
			}

			if (i % 8 == 0) {
				result = result.concat(" ");
			}
		}

		return result;
	}
	
	private void waitMicron(String string) {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			appendText("Wait for data happen -" + string);
			e.printStackTrace();
		}

	}
	
	private void sendData(String [] data) {
		for (int i = 0; i < data.length; i++) {
			String [] el = data[i].split(" ");
			ArrayUtils.reverse(el);
			for (int j = 0; j < el.length; j++) {
				communication.writeData(el[j]);
			}
		}
	}

	public void appendText(final String s) {
		display.syncExec(new Runnable() {
			public void run() {
				text.append(s);
			}
		});

	}
}
