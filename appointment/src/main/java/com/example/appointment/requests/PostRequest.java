package com.example.appointment.requests;


import com.example.appointment.appointment.entities.User;
import com.example.appointment.appointment.entities.UserRepository;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class PostRequest {
    static HashMap<String, Object> responseMap = new HashMap();

    //ADD NEW CASE FOR NEW FEATURE
    public static HashMap<String, Object> addUser(HashMap<String, Object> requestMap, UserRepository userRepository) throws Exception {
        User user = new User();
        user.setFirstName(requestMap.get("first_name").toString());
        user.setLastName(requestMap.get("last_name").toString());
        if (RegistrationUtil.isValidMobile(requestMap.get("mobile").toString())) {
            user.setMobile(requestMap.get("mobile").toString());
        } else {
            throw new Exception("Invalid mobile provided");
        }
        if (RegistrationUtil.isValidEmail(requestMap.get("email").toString())) {
            if(!RegistrationUtil.isRegistered(requestMap.get("email").toString(),userRepository)) {
                user.setEmail(requestMap.get("email").toString());
            }
            else {
                throw new Exception("Email already registered");
            }
        } else {
            throw new Exception("Invalid email provided");
        }
        if (RegistrationUtil.isCountry(requestMap.get("country").toString())) {
            user.setCountry(requestMap.get("country").toString());
        } else {
            throw new Exception("Invalid country provided");
        }
        userRepository.save(user);
        responseMap.put("id", user.getId());
        responseMap.put("message", "Successfully registered");
        responseMap.put("email", user.getEmail());
        return responseMap;
    }
}
