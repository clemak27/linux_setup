import json
import subprocess

user_setup_file_path="user_setup.sh"
config_file_path = './modules/system_config.json'

with open(config_file_path) as json_file:
    data = json.load(json_file)

    print(data['plasma']['description'])

    print("Installing " + str(len(data['plasma']['packages'])) + " packages:")
    packages = ' '.join(data['plasma']['packages'])
    subprocess.run(["pacman", "-S", packages])

    print("Executing " + str(len(data['plasma']['commands'])) + " commands:")
    for cmd in data['plasma']['commands']:
        subprocess.run([cmd], shell=True)

    print("Adding " + str(len(data['plasma']['packages'])) + " packages to user setup:")
    user_packages = ' '.join(data['plasma']['packages'])
    with open(user_setup_file_path, "a") as user_file:
        user_file.write("yay -S " + user_packages)
        user_file.write("\n")

    print("Adding " + str(len(data['plasma']['commands'])) + " commands to user setup:")
    for cmd in data['plasma']['commands']:
        with open(user_setup_file_path, "a") as user_file:
            user_file.write(cmd)
            user_file.write("\n")
