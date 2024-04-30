--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : schemat_better.vhf
-- /___/   /\     Timestamp : 04/16/2024 17:55:08
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl C:/Users/lab/gwieznda_flota_MHAT/schemat_better.vhf -w C:/Users/lab/gwieznda_flota_MHAT/schemat_better.sch
--Design Name: schemat_better
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity schemat_better is
   port ( lewo   : in    std_logic; 
          prawo  : in    std_logic; 
          zegar  : in    std_logic; 
          VGA_B  : out   std_logic; 
          VGA_G  : out   std_logic; 
          VGA_HS : out   std_logic; 
          VGA_R  : out   std_logic; 
          VGA_VS : out   std_logic);
end schemat_better;

architecture BEHAVIORAL of schemat_better is
   attribute BOX_TYPE   : string ;
   signal XLXN_4                        : std_logic;
   signal XLXN_5                        : std_logic_vector (7 downto 0);
   signal XLXN_6                        : std_logic;
   signal XLXI_2_CursorOn_openSignal    : std_logic;
   signal XLXI_2_Goto00_openSignal      : std_logic;
   signal XLXI_2_Home_openSignal        : std_logic;
   signal XLXI_2_NewLine_openSignal     : std_logic;
   signal XLXI_2_ScrollClear_openSignal : std_logic;
   signal XLXI_2_ScrollEn_openSignal    : std_logic;
   component kod_better
      port ( zegar           : in    std_logic; 
             lewo            : in    std_logic; 
             prawo           : in    std_logic; 
             znak_gotowy     : out   std_logic; 
             go_to_beginning : out   std_logic; 
             znak            : out   std_logic_vector (7 downto 0));
   end component;
   
   component VGAtxt48x20
      port ( Char_DI     : in    std_logic_vector (7 downto 0); 
             Home        : in    std_logic; 
             NewLine     : in    std_logic; 
             Goto00      : in    std_logic; 
             Clk_Sys     : in    std_logic; 
             Clk_50MHz   : in    std_logic; 
             CursorOn    : in    std_logic; 
             ScrollEn    : in    std_logic; 
             ScrollClear : in    std_logic; 
             Busy        : out   std_logic; 
             VGA_HS      : out   std_logic; 
             VGA_VS      : out   std_logic; 
             VGA_RGB     : out   std_logic; 
             Char_WE     : in    std_logic);
   end component;
   
   component BUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of BUF : component is "BLACK_BOX";
   
begin
   XLXI_1 : kod_better
      port map (lewo=>lewo,
                prawo=>prawo,
                zegar=>zegar,
                go_to_beginning=>open,
                znak(7 downto 0)=>XLXN_5(7 downto 0),
                znak_gotowy=>XLXN_4);
   
   XLXI_2 : VGAtxt48x20
      port map (Char_DI(7 downto 0)=>XLXN_5(7 downto 0),
                Char_WE=>XLXN_4,
                Clk_Sys=>zegar,
                Clk_50MHz=>zegar,
                CursorOn=>XLXI_2_CursorOn_openSignal,
                Goto00=>XLXI_2_Goto00_openSignal,
                Home=>XLXI_2_Home_openSignal,
                NewLine=>XLXI_2_NewLine_openSignal,
                ScrollClear=>XLXI_2_ScrollClear_openSignal,
                ScrollEn=>XLXI_2_ScrollEn_openSignal,
                Busy=>open,
                VGA_HS=>VGA_HS,
                VGA_RGB=>XLXN_6,
                VGA_VS=>VGA_VS);
   
   XLXI_3 : BUF
      port map (I=>XLXN_6,
                O=>VGA_R);
   
   XLXI_4 : BUF
      port map (I=>XLXN_6,
                O=>VGA_G);
   
   XLXI_5 : BUF
      port map (I=>XLXN_6,
                O=>VGA_B);
   
end BEHAVIORAL;


