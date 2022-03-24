int main() {
  int* MY_ADDRESS = (int*)0xC1A0C1A0;
  int MY_DATA = 0xFABA1210;

  *(MY_ADDRESS) = MY_DATA;
  return 0;
}

