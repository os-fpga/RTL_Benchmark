//////////////////////////////////////////////////////////////////////////////////
#include <stdlib.h>
#include <stdio.h>

//////////////////////////////////////////////////////////////////////////////////

unsigned short crc_ip(void * ptr, unsigned count)
{
    unsigned short checksum;
    unsigned short * addr = (unsigned short *)ptr;
    
    /********** code from rfc1071 **********/
    {
        /* Compute Internet Checksum for "count" bytes
        *         beginning at location "addr".
        */
       
        long sum = 0;
        count += count;  /* make passed word count into byte count */
        
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
        
        // curr CRC realisation expects to do the final 1s complement of the checksum in the raw-code
        checksum = (unsigned short)sum;
        // or?
        //checksum = ~sum;
   }
    /******** end of RFC 1071 code **********/
    
    return checksum;
}

//////////////////////////////////////////////////////////////////////////////////
