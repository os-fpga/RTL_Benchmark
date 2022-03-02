--
--	post.vhd
--
--	Cordic post-processing block
--
-- 	Compensate cordic algorithm K-factor; divide Radius by 1.165. 
--	Actual implementation: Radius := Ri * 0.859
--
--	Position calculated angle in correct quadrant.
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity post is
	port(
		clk	: in std_logic;
		ena	: in std_logic;

		Ai	: in std_logic_vector(15 downto 0);
		Ri	: in std_logic_vector(19 downto 0);
		Q	: in std_logic_vector(2 downto 0);

		Ao	: out std_logic_vector(15 downto 0);
		Ro	: out std_logic_vector(19 downto 0));

	constant cPI2 : natural := 2**14;		-- Pi/2 = 0x4000
	constant cPI : natural := 2**15;		-- Pi/2 = 0x8000
	constant c2PI : natural := 2**16;		-- Pi = 0x10000 = 0x0000
end entity post;

architecture dataflow of post is
begin
	radius: block
		signal RadA, RadB, RadC : natural range 0 to 2**20;
	begin
		process(clk)
			variable tmp : natural;
		begin
			tmp := conv_integer( unsigned(Ri) );

			if (clk'event and clk = '1') then
				if (ena = '1') then
					RadA <= tmp - (tmp / 8);
					RadB <= RadA - (RadA / 64);
					RadC <= RadB - (RadB / 512);
				end if;
			end if;
		end process;

		-- assign output
		Ro <= std_logic_vector(conv_unsigned(RadC, 20));
	end block radius;

	angle: block
		signal dQ : std_logic_vector(2 downto 1);
		signal ddQ : std_logic;
		signal AngStep1 : unsigned(14 downto 0);
		signal AngStep2 : unsigned(15 downto 0);
		signal AngStep3 : unsigned(16 downto 0);
	begin
		angle_step1: process(clk)
			variable overflow : std_logic;
			variable AngA, AngB, Ang : unsigned(14 downto 0);
		begin
			-- check if angle is negative, if so set it to zero
			overflow := Ai(14) and Ai(13);

			if (overflow = '1') then
				Anga := (others => '0');
			else
				AngA := unsigned('0' & Ai(13 downto 0));
			end if;

			-- step 1: Xabs and Yabs are swapped
			-- Calculated angle is the angle between vector and Y-axis.
			-- ActualAngle = PI/2 - CalculatedAngle
		 	AngB := cPI2 - AngA;

			if (Q(0) = '1') then
				Ang := AngB;
			else
				Ang := AngA;
			end if;

			if (clk'event and clk = '1') then
				if (ena = '1') then
					AngStep1 <= Ang;
					dQ <= q(2 downto 1);
				end if;
			end if;
		end process angle_step1;


		angle_step2: process(clk)
			variable AngA, AngB, Ang : unsigned(15 downto 0);
		begin
			AngA := ('0' & AngStep1);

			-- step 2: Xvalue is negative
			-- Actual angle is in the second or third quadrant
			-- ActualAngle = PI - CalculatedAngle
			AngB := cPI - AngA;

			if (dQ(1) = '1') then
				Ang := AngB;
			else
				Ang := AngA;
			end if;

			if (clk'event and clk = '1') then
				if (ena = '1') then
					AngStep2 <= Ang;
					ddQ <= dQ(2);
				end if;
			end if;
		end process angle_step2;


		angle_step3: process(clk)
			variable AngA, AngB, Ang : unsigned(16 downto 0);
		begin
			AngA := ('0' & AngStep2);

			-- step 3: Yvalue is negative
			-- Actual angle is in the third or fourth quadrant
			-- ActualAngle = 2PI - CalculatedAngle
			AngB := c2PI - AngA;

			if (ddQ = '1') then
				Ang := AngB;
			else
				Ang := AngA;
			end if;
			
			if (clk'event and clk = '1') then
				if (ena = '1') then
					AngStep3 <= Ang;
				end if;
			end if;
		end process angle_step3;

		Ao <= std_logic_vector( AngStep3(15 downto 0) );
	end block angle;
end;


