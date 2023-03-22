package cust.slei.login;

import org.apache.shiro.codec.Hex;
import org.apache.shiro.crypto.hash.Sha1Hash;

import java.security.SecureRandom;

public class createPassword {

    private static SecureRandom random = new SecureRandom();

    public static byte[] generateSalt(int numBytes) {
        byte[] bytes = new byte[numBytes];
        random.nextBytes(bytes);
        return bytes;
    }

    public static String encryptPassword(String password) {
        byte[] salt = generateSalt(8);
        return encryptPassword(password, salt);
    }

    public static String encryptPassword(String password, byte[] salt) {
        Sha1Hash sh = new Sha1Hash(password, salt, 1024);
        return Hex.encodeToString(salt) + sh.toHex();
    }

    public static boolean validatePassword(String plainPassword, String encryptedPassword) {
        byte[] salt = Hex.decode(encryptedPassword.substring(0, 16));
        String ep = encryptPassword(plainPassword, salt);
        return ep.equals(encryptedPassword);
    }

    public static void main(String[] args) {
        String password = "123456";
        String code = "6d63cb71688280f0f19f735cd7a043f499755a9398634f3d85e645e2";
        System.out.println(encryptPassword(password));
        System.out.println(validatePassword(password, code));


    }
}
