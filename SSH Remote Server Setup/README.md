
# SSH Remote Server Setup on AWS EC2 (Windows)

## Objective
Set up a remote Linux server on AWS and configure it to allow SSH access using a custom SSH key pair on a Windows machine.

---

## Tools & Environment
- **Operating System**: Windows 11
- **Cloud Provider**: AWS EC2
- **Instance Type**: t2.micro (Free Tier eligible)
- **Linux OS on Server**: Ubuntu 22.04 LTS
- **SSH Tool**: Windows Command Prompt / PowerShell
- **Key Pair Type**: RSA 4096-bit

---

## Steps Performed

### 1. Generated SSH Key Pair on Windows

Generated a 4096-bit RSA key pair using the following command:

```bash
ssh-keygen -t rsa -b 4096 -f C:\Users\Rusha.Shah\.ssh\aws-key2
```

This created:
- **Private key**: `C:\Users\Rusha.Shah\.ssh\aws-key2`
- **Public key**: `C:\Users\Rusha.Shah\.ssh\aws-key2.pub`

---

### 2. Launched EC2 Instance

Created an EC2 instance via the AWS Console with the following settings:
- **Operating System**: Ubuntu 22.04 LTS
- **Key Pair**: Proceeded without a key pair (we will use a custom one)
- **Instance Type**: t2.micro

---

### 3. Added SSH Public Key to EC2

Connected to the instance using **EC2 Instance Connect** (browser-based terminal) and ran the following commands to add the public key:

```bash
mkdir -p ~/.ssh
echo "<contents of aws-key2.pub>" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
```

>  Replace `<contents of aws-key2.pub>` with the actual content of the public key file.

---

### 4. Connected to EC2 Using SSH from Local Machine

From Windows, used the private key to connect to the EC2 instance:

```bash
ssh -i C:\Users\Rusha.Shah\.ssh\aws-key2 ubuntu@<EC2-PUBLIC-IP>
```

>  Replace `<EC2-PUBLIC-IP>` with your actual EC2 instance's public IP address.

---

### 5. Configured SSH Alias for Convenience

Created a config entry in `C:\Users\Rusha.Shah\.ssh\config`:

```ini
Host myaws
    HostName <EC2-PUBLIC-IP>
    User ubuntu
    IdentityFile C:\Users\Rusha.Shah\.ssh\aws-key2
```

Now, I can simply connect using the alias:

```bash
ssh myaws
```

---

## Outcome

- Successfully set up SSH access to an AWS EC2 instance using a custom key pair on Windows.
- Verified SSH connection using both direct IP and alias.
- **Private key remains secure and is not committed or shared in any public repository.**

---

## Notes

- Ensure proper permissions:
  - `~/.ssh` → `chmod 700`
  - `authorized_keys` → `chmod 600`
- Private key should always remain secure and private.
- Avoid committing any keys to Git or public repositories.
