package webexponentiator.serialcomm;

public class Command {
	public static final int MAX_WORD = 512;
	public static final String mn_read_base        = "00000000";
	public static final String mn_read_modulus     = "00000001";
	public static final String mn_read_exponent    = "00000010";
	public static final String mn_read_residuum    = "00000011";
	public static final String mn_count_power      = "00000100";
	public static final String mn_show_result      = "00000101";
	public static final String mn_prepare_for_data = "00000111";
}
