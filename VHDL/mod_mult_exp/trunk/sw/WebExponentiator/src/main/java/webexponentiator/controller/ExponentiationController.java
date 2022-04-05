package webexponentiator.controller;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import webexponentiator.util.Command;
import webexponentiator.util.Communication;

@Controller
public class ExponentiationController {
	
	/** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	private static Communication communication;
	
	@RequestMapping("/exponentiation")
	public String showExponentiation(Model model) {
		String ret = getPort();
		ArrayList<String> exponentiation = modularExponentiation();
	    logger.info("Starting exponentiation");
		if (null == exponentiation) {
			exponentiation = new ArrayList<String>();
			exponentiation.add(ret);
		}
		logger.info("Ending exponentiation");
		model.addAttribute("exponentiation", exponentiation);
		return "exponentiate";
	}
	
	private synchronized ArrayList<String> modularExponentiation() {
		ArrayList<String> result = new ArrayList<String>();
		if (communication.getConnected()) {
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
			logger.info("Send base");
			result.add(sendBase(base.toString(10)));
			logger.info("Send modulus");
			result.add(sendModulus(modulus.toString(10)));
			logger.info("Send exponent");
			result.add(sendExponent(exponent.toString(10)));
			logger.info("Send residuum");
			result.add(sendResiduum(residuum.toString(10)));
			logger.info("Send power");
			result.add(sendPower());
			logger.info("Send result");
			result.add(sendResult());
			logger.info("Send prepare");
			result.add(sendPrepare());
			result.add("Expected result " + expectedResult.toString(16));
			result.add("Equal = 0? " + expectedResult.toString(16).compareTo(result.get(5)));
			communication.disconnect();
			return result;
		}
		return null;
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
		return "count power - " + communication.readData();
	}

	private String sendResiduum(String string) {
		String residuum = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_residuum, residuum };
		sendData(send);
		waitMicron("residuum");
		return "residuum - " + string + " " + communication.readData();
	}

	private String sendExponent(String string) {
		String exponent = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_exponent, exponent };
		sendData(send);
		waitMicron("exponent");
		return "exponent - " + string + " " + communication.readData();
	}

	private String sendModulus(String string) {
		String modulus = parseDataToSend(string, 10);
		String[] send = { Command.mn_read_modulus, modulus };
		sendData(send);
		waitMicron("modulus");
		return "modulus - " + string + " " + communication.readData();
	}

	private String sendBase(String data) {
		String base = parseDataToSend(data, 10);
		String[] send = { Command.mn_read_base, base };
		sendData(send);
		waitMicron("base");
		return "base - " + data + " " + communication.readData();
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
	
	private void sendData(String[] data) {
		for (int i = 0; i < data.length; i++) {
			String[] el = data[i].split(" ");
			ArrayUtils.reverse(el);
			for (int j = 0; j < el.length; j++) {
				communication.writeData(el[j]);
			}
		}
	}
	
	private void waitMicron(String string) {
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			logger.error("Wait for data happen -" + string);
			e.printStackTrace();
		}

	}
	
	private synchronized String getPort() {
		logger.info("getPort() start");
		if (communication == null) {
			communication = new Communication();
		}
		ArrayList<String> ports = communication.searchForPorts();
		if (communication.getConnected()) {
			return "COM3";
		}
		for (String port : ports) {
			if (port.contains("COM3")) {
				communication.connect();
				if (communication.getConnected() == true) {
					if (communication.initIOStream() == true) {
						return "COM3";
					}
					return "Something happens - initIOStream";
				}
				return "Something happens - getConnected";
			}
		}
		logger.info("getPort() end");
		return "Something happens - COM3 not found";
	}
}
