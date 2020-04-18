package com.example.appointment.requests;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

public class HttpRequestUtil {
    public static Map<String, String> postRequests = postRequestMap();
    public static Map<String, String> getRequests = getRequestMap();
    public static Map<String, String> putRequests = putRequestMap();

    public static HashMap<String, Object> generateRequestMap(String JSONString) throws JSONException {
        HashMap<String, Object> response = new HashMap<String, Object>();
        JSONObject jObject = new JSONObject(JSONString);
        Iterator<?> keys = jObject.keys();

        while (keys.hasNext()) {
            String key = (String) keys.next();
            Object value = jObject.get(key);
            response.put(key, value);

        }
        return response;
    }

    public static HashMap<String, Object> generateErrorResponse(Exception e) {
        HashMap<String, Object> responseMap = new HashMap();
        responseMap.put("code", 1000);
        responseMap.put("message", "An error occured");
        if (e.getLocalizedMessage() != null) {
            responseMap.put("description", e.getLocalizedMessage());
        }
        return responseMap;
    }

    private static Map<String, String> putRequestMap() {
        // TODO Auto-generated method stub
        return null;
    }

    private static Map<String, String> getRequestMap() {
        // TODO Auto-generated method stub
        return null;
    }

    private static Map<String, String> postRequestMap() {
        return null;
    }
}
