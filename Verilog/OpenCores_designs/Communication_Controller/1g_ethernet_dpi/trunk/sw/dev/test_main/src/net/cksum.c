/*
 *
 * Portable C implementation of the Internet checksum, derived 
 * from Braden, Borman, and Partridge's example implementation 
 * in RFC 1071.
 *
 */

unsigned short cksum(void * ptr, int count)
{
    unsigned short checksum;
    unsigned short *addr = (unsigned short *)ptr;
    
    /********** code from rfc1071 **********/
    {
        /* Compute Internet Checksum for "count" bytes
        *         beginning at location "addr".
        */
       
        long sum = 0;
        
        while( count > 1 ) 
        {
            /*  This is the inner loop */
            sum += *addr++;
            count -= 2;
        }
        
        /*  Add left-over byte, if any */
        if( count > 0 )
            sum += * (unsigned char *) addr;
        
        /*  Fold 32-bit sum to 16 bits */
        while (sum>>16)
            sum = (sum & 0xffff) + (sum >> 16);
        
        checksum = ~sum;
   }
    /******** end of RFC 1071 code **********/
    
    return checksum;
}

