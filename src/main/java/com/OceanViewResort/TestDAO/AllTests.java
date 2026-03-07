package com.OceanViewResort.TestDAO;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

import com.OceanViewResort.TestBeans.UserTest;

@Suite
@SelectClasses({ DBConnectionTest.class, GuestDAOTest.class, ReservationDAOTest.class, RoomDAOTest.class,
		UserTest.class })
public class AllTests {

}
