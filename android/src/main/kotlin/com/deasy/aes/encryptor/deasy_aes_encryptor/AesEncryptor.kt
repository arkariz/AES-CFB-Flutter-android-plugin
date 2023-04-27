package com.deasy.aes.encryptor.deasy_aes_encryptor

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Base64
import java.io.*
import java.nio.charset.Charset
import java.security.SecureRandom
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

// Read Encrypt and Decrypt value from API
object AESEncryptor {

    @Throws(Exception::class)
    fun encrypt(
        plainMessage: String,
        key: String,
    ): String {
        val symKeyHex = key
        val symKeyData = symKeyHex.toByteArray(charset("UTF-8"))

        val encodedMessage = plainMessage.toByteArray( Charset.forName("UTF-8"))
        try {
            val cipher = Cipher.getInstance("AES/CFB/NoPadding")
            val blockSize = cipher.blockSize
            // create the key
            val symKey = SecretKeySpec(symKeyData, "AES")

            // generate random IV using block size (possibly create a method for
            // this)
            val rnd = SecureRandom.getInstance("SHA1PRNG")

            val ivData = ByteArray(blockSize)
            rnd.nextBytes(ivData)
            val iv = IvParameterSpec(ivData)

            cipher.init(Cipher.ENCRYPT_MODE, symKey, iv)

            val encryptedMessage = cipher.doFinal(encodedMessage)

            // concatenate IV and encrypted message
            val ivAndEncryptedMessage = ByteArray(ivData.size + encryptedMessage.size)
            System.arraycopy(ivData, 0, ivAndEncryptedMessage, 0, blockSize)
            System.arraycopy(
                encryptedMessage, 0, ivAndEncryptedMessage,
                blockSize, encryptedMessage.size
            )

            return Base64.encodeToString(ivAndEncryptedMessage, Base64.DEFAULT)
        } catch (e: Exception) {
            throw IllegalArgumentException(
                "key argument does not contain a valid AES key"
            )
        }

    }

    @Throws(Exception::class)
    fun decrypt(
        ivAndEncryptedMessageBase64: String,
        key: String
    ): String {
        try {
            val symKeyHex = key
            val symKeyData = symKeyHex.toByteArray(charset("UTF-8"))
            //final byte[] ivAndEncryptedMessage = Base64.decodeBase64(ivAndEncryptedMessageBase64);
            val ivAndEncryptedMessage = Base64.decode(ivAndEncryptedMessageBase64, Base64.DEFAULT)

            val cipher = Cipher.getInstance("AES/CFB/NoPadding")
            val blockSize = cipher.blockSize

            // create the key
            val symKey = SecretKeySpec(symKeyData, "AES")

            // retrieve random IV from start of the received message
            val ivData = ByteArray(blockSize)
            System.arraycopy(ivAndEncryptedMessage, 0, ivData, 0, blockSize)
            val iv = IvParameterSpec(ivData)

            // retrieve the encrypted message itself
            val encryptedMessage = ByteArray(ivAndEncryptedMessage.size - blockSize)
            System.arraycopy(
                ivAndEncryptedMessage, blockSize,
                encryptedMessage, 0, encryptedMessage.size
            )

            cipher.init(Cipher.DECRYPT_MODE, symKey, iv)

            val encodedMessage = cipher.doFinal(encryptedMessage)

            // concatenate IV and encrypted message

            return String(
                encodedMessage,
                Charset.forName("UTF-8")
            )
        } catch (e: Exception) {
            e.printStackTrace()
            return "Something Wrong"
        }

    }
}