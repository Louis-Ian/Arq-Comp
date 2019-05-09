from pprint import pprint

def flip_bits(bin_arr):

    jam = bin_arr[9:12]
    next_addr = bin_arr[0:9]

    return jam + next_addr + bin_arr[12:]



def read_rom():

    with open('microprog.rom', 'rb') as rom:
        with open('microprog_flipped.rom', 'wb') as f_rom:

            cmds = rom.read()

            for i in range(0, len(cmds), 8):
                # print('ADDR = 0x%03X   ' % i, end='', flush=True)
                hex_str = ''
                fmt_str = ''

                for j in range(5):
                    hex_str += '  0x{:02X}'.format(cmds[i + 4 - j]) + 3 * ' '
                    fmt_str += '{:0>8b} '.format(cmds[i + 4 - j])

                bin_arr = list(fmt_str.replace(' ', ''))
                new_bin = (4 * ['0']) + flip_bits(bin_arr[4:])

                # print(''.join(new_bin))
                # print('')

                t = [int(''.join(new_bin[i:i+8]), 2) for i in range(0, len(new_bin), 8)]
                f_rom.write(bytearray(t))

            f_rom.close()
        rom.close()

def main():
    read_rom()


if __name__ == '__main__':
    read_rom()