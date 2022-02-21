# Resetting Password

## Resetting user passwords

!!! info
    To reset passwords for LDAP (or other single sign-on services) users, please contact your single sign-on administrator.

openITCOCKPIT has a CLI tool for resetting user passwords. Please note, however, that only passwords for local accounts can be reset.

```bash
oitc reset_password --print
```

![reset password](/images/oitc_reset_password.png)

The system will display a list of all users whose passwords can be reset. Using the --print option, the password will be displayed on the terminal. The user will also receive an email with the new password.

![password mail](/images/oitc_new_password_mail.png)
