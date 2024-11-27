# Requirements

 - ansible
 - curl
 - git

## Installing requirements
```
sudo dnf install -y ansible curl git psutil
```

# Execute the entire playbook with

```
 ansible-playbook ansible-desktop.yml --ask-become-pass
```

# Execute only selected tags

```
 ansible-playbook ansible-desktop.yml --ask-become-pass --tags "java"
```

## TODO:
 - [ ] Add H264 [Codec](https://fedoraproject.org/wiki/OpenH264)
