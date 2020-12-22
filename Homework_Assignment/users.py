# import modules
import paramiko

def user_add(user, host, port=22):
    #specifed host(s)
    hostname    = "104.236.34.19"
    username    = "centos"
    # public key
    ssh_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkVmYxQjVLe8bHrfExUK9nEaYEoXVnkJCowQQOSdhSUud8iFfcXPv4ecoNcACss6zefgfWUcTKmk/e8IptZx8MJm5PqNynivMjYLYZyV8Pxi1Z/w0fIlisFKpnFNCgel5JEKJzosOqn0NIYAvhBDdxaolx/Lnear1ZIIbAgxKmGUdyPGS3G65/X9ssybjeiYqBlj+FU1BaWGMmeCXLLikd5DMfjJKmSqqYhVVH96GABpQTjCkT+pOklW3HR0Ajp55igecdxN+e3H1g/KLMAG2ydBmtf+apgCDC/mBZE9QDCAG5TT6CT4a72JKNF9uRtQJM0kYvW7oM+iUDdkJfSxTf abdugofir@Abdugofirs-MacBook-Pro.local"
    # initialize the SSH client
    client = paramiko.SSHClient()
    # add to known hosts
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    # establishing connection
    client.connect(hostname=hostname, username=username)
    cmd         = "sudo useradd {}".format(user)
    ssh_dir     = "sudo mkdir /home/{}/.ssh && sudo touch /home/{}/.ssh/authorized_keys".format(user, user)
    key         = "echo {} | sudo tee -a /home/{}/.ssh/authorized_keys".format(ssh_pub_key, user)
    client.exec_command(cmd)
    client.exec_command(ssh_dir)
    client.exec_command(key)
    stdin, stdout, stderr = client.exec_command(key)
    print(stdout.read().decode())
    err = stderr.read().decode()
    if err:
        print(err)

user_add("Alina", "104.236.34.19")


def user_list():
    hostname    = "104.236.34.19"
    username    = "centos"
    # initialize the SSH client
    client = paramiko.SSHClient()
    # add to known hosts
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname=hostname, username=username)
    cmd         = "sudo cat /etc/passwd | awk -F : '{ print $1, $3, $5 }'"
    client.exec_command(cmd)
    stdin, stdout, stderr = client.exec_command(cmd)
    print(stdout.read().decode())
    err = stderr.read().decode()
    if err:
        print(err)
print("Listing users & ids & comments")
user_list()

def remove_user(user):
    hostname    = "104.236.34.19"
    username    = "centos"

    # initialize the SSH client
    client = paramiko.SSHClient()
    # add to known hosts
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(hostname=hostname, username=username)
    cmd         = "sudo userdel -r {} && sudo rm -rf /home/{}".format(user, user)
    client.exec_command(cmd)

print("Deleting a User")
remove_user('macbook')