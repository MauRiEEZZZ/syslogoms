import subprocess
import time
rsyslog_conf_path = "/etc/rsyslog.conf"

def print_ok(input_str):
    '''
    Print given text in green color for Ok text
    :param input_str:
    '''
    print("\033[1;32;40m" + input_str + "\033[0m")


def handle_error(e, error_response_str):
    error_output = e.decode('ascii')
    print_error(error_response_str)
    print_error(error_output)
    return False



def main():
    with open(rsyslog_conf_path, "rt") as fin:
        with open("tmp.txt", "wt") as fout:
            for line in fin:
                if "imudp" in line or "imtcp" in line:
                    fout.write(line.replace("#", "")) if "#" in line else fout.write(line)
                else:
                    fout.write(line)
    command_tokens = ["sudo", "mv", "tmp.txt", rsyslog_conf_path]
    write_new_content = subprocess.Popen(command_tokens, stdout=subprocess.PIPE)
    time.sleep(3)
    o, e = write_new_content.communicate()
    if e is not None:
        handle_error(e, error_response_str="Error: could not change Rsyslog.conf configuration  in -" + rsyslog_conf_path)
        return False
    print_ok("Rsyslog.conf configuration was changed to fit required protocol - " + rsyslog_conf_path)
    return True

main()