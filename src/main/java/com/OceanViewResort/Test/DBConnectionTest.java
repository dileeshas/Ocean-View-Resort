package com.OceanViewResort.Test;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Dao.DBConnection;

public class DBConnectionTest {

    @Test
    public void testDatabaseConnection() {

        try {
            Connection conn = DBConnection.getConnection();
            assertNotNull(conn);

        } catch (Exception e) {
            fail("Database connection failed");
        }
    }
}
