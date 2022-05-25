/*
 * tbd
 *
 */

void *xil_memset(void *s, int c, unsigned int count)
{

	if (!count)
		return s;

	c &= 0xFF;
//
		char *xs = (char *) s;

		while (count--)
			*xs++ = c;
		return s;
//
}
