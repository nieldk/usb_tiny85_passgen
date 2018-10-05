This is the source code package for DIY USB password generator by Joonas Pihlajamaa, 
published at Code and Life, http://codeandlife.com/2012/03/03/diy-usb-password-generator/

Modifications are made by me, to enable building on newer avr-gcc versions than original code.

A new password can be generated just by tabbing CAPS LOCK 4 times to start password regeneration,
 and one tab for each password character generated, 16 is the default password length).

Follwing parameters are defined:

    PASS_LENGTH		Controls the length (16) of generated passwords
    SEND_ENTER		Can be defined to 0 if you do not want the device also to send ENTER after typing the keyboard
    measuring_message	Contain the messages that are displayed when generating a new password
    finish_message	Contain the messages that are displayed when saving a new password

I hope you have fun with this project!

- Niel Nielsen
