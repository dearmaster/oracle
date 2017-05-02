package com.master.oracle;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProcedureInvocationDemo {

    private static final String driver = "oracle.jdbc.driver.OracleDriver";
    private static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:eval";
    private static final String username = "LESLY";
    private static final String password = "LESLY123";


    public static void main(String[] args) {
        invokeProcedure();
    }

    public static void invokeProcedure() {
        Statement stmt = null;
        ResultSet rs = null;
        Connection conn = null;

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
            CallableStatement proc = null;
            proc = conn.prepareCall("{ call LESLY.LOAD_ALL_USER_INFO(?) }");
            proc.registerOutParameter(1,oracle.jdbc.OracleTypes.CURSOR);
            proc.execute();//执行
            rs = (ResultSet)proc.getObject(1);

            List<User> list = encapsulateObject(rs);

            for(User user : list) {
                System.out.println(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static List<User> encapsulateObject(ResultSet rs) {
        List<User> list = new ArrayList<User>();
        if(null != rs) {
            try {
                while(rs.next()) {
                    User user = new User();
                    user.setUserid(rs.getInt("U_ID"));
                    user.setUsername(rs.getString("USERNAME"));
                    user.setGender(rs.getString("GENDER"));
                    user.setBirthday(rs.getDate("BIRTHDAY"));
                    user.setAddress(rs.getString("ADDRESS"));
                    list.add(user);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

}