/*
 *  FpgaNeoPixel - A spi to ws2812 machine
 *
 *  Copyright (C) 2020  Hirosh Dabui <hirosh@dabui.de>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
#ifndef FPGA_NEOPIXEL_H
#define FPGA_NEOPIXEL_H
#include <SPI.h>
#include <Adafruit_NeoPixel.h>
class FPGA_NeoPixel : public Adafruit_NeoPixel {

  public:
    explicit FPGA_NeoPixel(uint16_t n, uint16_t pin = 6 /* is not needed */,
        neoPixelType type = NEO_GRB + NEO_KHZ800) : Adafruit_NeoPixel(n, pin, type) {};

    void begin() {
      pinMode(READY_PIN, INPUT_PULLUP);
      pinMode(RESETN_PIN, OUTPUT);
      digitalWrite(SS, HIGH);

      delay(1);

      SPI.begin();
      SPI.beginTransaction(SPISettings(16000000, MSBFIRST, SPI_MODE0));

      digitalWrite(RESETN_PIN, 0);
      delay(200);
      digitalWrite(RESETN_PIN, 1);
      delay(1000);

      Adafruit_NeoPixel::begin();
    }

    void show() {
      if (!pixels) return;

      wait_asic();

      uint16_t i = numBytes; // Loop counter
      uint8_t *p = pixels; // pointer to next byte

      for (uint16_t n = 0; n < numBytes / 3; n++) {
        grb(*p++, *p++, *p++);// brg
      }
      sync();
    }

  private:
    void wait_asic() {
      for (;;) {
        int val = digitalRead(READY_PIN);
        if (val == 0) break;
      }
    }

    inline void grb(uint8_t b, uint8_t r, uint8_t g) {
      digitalWrite(SS, LOW);
      SPI.transfer(0);
      SPI.transfer(g);
      SPI.transfer(r);
      SPI.transfer(b);
      digitalWrite(SS, HIGH);
    }

    /* asic show leds and empty your fifo*/
    inline void sync() {
      digitalWrite(SS, LOW);
      SPI.transfer(0xde);
      SPI.transfer(0xad);
      SPI.transfer(0xbe);
      SPI.transfer(0xaf);
      digitalWrite(SS, HIGH);
    }
};
#endif // FPGA_NEOPIXEL_H

