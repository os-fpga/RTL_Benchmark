
cd 'C:\qaz\_CVS_WORK\units\i2s_to_wb\scilab\tone_roms'

clear

exec('make_tone_rom.sci');

make_tone_rom( 440, 8000 );
make_tone_rom( 660, 8000 );

make_tone_rom( 440, 48000 );
make_tone_rom( 660, 48000 );

make_tone_rom( 1, 48000 );
