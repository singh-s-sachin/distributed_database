package com.example.appointment.appointment.entities;

import org.springframework.data.repository.CrudRepository;

import com.example.appointment.appointment.entities.User;

public interface UserRepository extends CrudRepository<User, Long> {

}
