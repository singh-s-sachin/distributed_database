package com.example.appointment.appointment;

import java.util.HashMap;

import com.example.appointment.requests.HttpRequestUtil;
import com.example.appointment.requests.PostRequest;
import com.example.appointment.appointment.entities.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(path = "/user")
public class UserRegistration {
    static HashMap<String, Object> responseMap = new HashMap<>();

    @Autowired
    private
    UserRepository userRepository;

    @PostMapping(path = "/register")
    @ResponseStatus(HttpStatus.CREATED)
    public @ResponseBody
    HashMap<String, Object> userRequests(HttpServletRequest request) {
        try {
            HashMap<String, Object> requestMap = HttpRequestUtil.generateRequestMap(request.getParameter("JSONString"));
            responseMap = PostRequest.addUser(requestMap, userRepository);
        } catch (Exception e) {
            responseMap = HttpRequestUtil.generateErrorResponse(e);
        }
        return responseMap;
    }

}

