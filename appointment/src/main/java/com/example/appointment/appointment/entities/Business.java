package com.example.appointment.appointment.entities;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "business_users")
@EntityListeners(AuditingEntityListener.class)
public class Business 
{
	@Id
    @Column(name = "business_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long bid;
	@Column(name = "user_id", nullable = false)
    private long user_id;
    @Column(name = "token_amount", nullable = false)
    private double tokenAmount;
    @Column(name = "business_name", nullable = false)
    private String businessName;
    @Column(name = "country", nullable = false)
    private String country;
    @Column(name = "state", nullable = false)
    private String state;
    @Column(name = "ZIP", nullable = false)
    private int zip;
    @Column(name = "address", nullable = false)
    private String address;
    @Column(name = "mobile", nullable = false)
    private String mobile;
	@Column(name = "email_address", nullable = false, unique = true)
    private String email;
	@Column(name = "product_type", nullable = false)
    private String type;
	@Column(name = "product_name", nullable = false)
    private String name;
	@Column(name = "slot_time", nullable = false)
    private int slotTime;
	@Column(name = "latitude", nullable = false)
    private String latitude;
	@Column(name = "longitude", nullable = false)
    private String longitude;
    @Column(name = "created_at", nullable = false)
    @CreatedDate
    private Date createdAt;
    @Column(name = "updated_at", nullable = false)
    @LastModifiedDate
    private Date updatedAt;
	public long getBid() {
		return bid;
	}
	public void setBid(long bid) {
		this.bid = bid;
	}
	public long getUser_id() {
		return user_id;
	}
	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}
	public double getTokenAmount() {
		return tokenAmount;
	}
	public void setTokenAmount(double tokenAmount) {
		this.tokenAmount = tokenAmount;
	}
	public String getBusinessName() {
		return businessName;
	}
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getZip() {
		return zip;
	}
	public void setZip(int zip) {
		this.zip = zip;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSlotTime() {
		return slotTime;
	}
	public void setSlotTime(int slotTime) {
		this.slotTime = slotTime;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
}
