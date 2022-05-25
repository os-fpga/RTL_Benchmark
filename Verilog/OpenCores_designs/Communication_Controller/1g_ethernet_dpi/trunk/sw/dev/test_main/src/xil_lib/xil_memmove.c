/*
 * tbd
 *
 */

void *xil_memmove(void *d, const void *s, unsigned int count)
{
	unsigned long dst, src;

	if (!count)
		return d;

	if (d < s) {
		dst = (unsigned long) d;
		src = (unsigned long) s;

		if ((count < 8) || ((dst ^ src) & 3))
			goto restup;

		if (dst & 1) {
			*(char *)dst++ = *(char *)src++;
			count--;
		}
		if (dst & 2) {
			*(short *)dst = *(short *)src;
			src += 2;
			dst += 2;
			count -= 2;
		}
		while (count > 3) {
			*(long *)dst = *(long *)src;
			src += 4;
			dst += 4;
			count -= 4;
		}
restup:
		while (count--)
			*(char *)dst++ = *(char *)src++;
	} else {
		dst = (unsigned long) d + count;
		src = (unsigned long) s + count;

		if ((count < 8) || ((dst ^ src) & 3))
			goto restdown;

		if (dst & 1) {
			src--;
			dst--;
			count--;
			*(char *)dst = *(char *)src;
		}
		if (dst & 2) {
			src -= 2;
			dst -= 2;
			count -= 2;
			*(short *)dst = *(short *)src;
		}
		while (count > 3) {
			src -= 4;
			dst -= 4;
			count -= 4;
			*(long *)dst = *(long *)src;
		}
restdown:
		while (count--) {
			src--;
			dst--;
			*(char *)dst = *(char *)src;
		}
	}

	return d;
}
