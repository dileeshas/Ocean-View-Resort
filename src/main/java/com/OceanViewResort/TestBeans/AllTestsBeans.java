package com.OceanViewResort.TestBeans;

import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

@Suite
@SelectClasses({ GuestTest.class, ReservationTest.class, RoomTest.class, UserTest.class })
public class AllTestsBeans {

}
