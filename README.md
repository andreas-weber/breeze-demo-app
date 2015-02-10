# andreas-weber/breeze-demo-app

Sample-Application to tryout the workflow of packaging and installing projects.

## Usage

### Environment

Boot:

```
vagrant up
```

Enter virtual machine:

```
vagrant ssh
```

### Build and Install Package

Package will be created in `/vagrant/build/package`.

```
cd /vagrant
composer install
ant package
sudo dpkg --install build/package/breeze-demo-app_0.0.1_all.deb
```

Visit [http://192.168.56.150:8080](http://192.168.56.150:8080) after installation to see application is up and running.

### Package Manager

```
# show package content
dpkg --contents breeze-demo-app.deb

# show package info
dpkg --info breeze-demo-app.deb

# install package
dpkg --install breeze-demo-app.deb

# remove package
dpkg --remove breeze-demo-app
```
