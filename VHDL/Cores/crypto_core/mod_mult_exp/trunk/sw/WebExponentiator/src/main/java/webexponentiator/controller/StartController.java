package webexponentiator.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.stereotype.Controller;
//import org.springframework.web.servlet.mvc.Controller;

@Controller
public class StartController {

    protected final Log logger = LogFactory.getLog(getClass());

    @GetMapping("/start")
    public ModelAndView handleRequest()
            throws ServletException, IOException {

    	String now = (new Date()).toString();
        logger.info("Returning hello view with " + now);
        
        Map<String, Object> myModel = new HashMap<String, Object>();
        myModel.put("now", now);

		return new ModelAndView("start", "model", myModel);
    }

}