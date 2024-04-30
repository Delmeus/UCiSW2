<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="zegar" />
        <signal name="VGA_HS" />
        <signal name="VGA_VS" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="XLXN_7(7:0)" />
        <signal name="VGA_R" />
        <signal name="VGA_G" />
        <signal name="VGA_B" />
        <signal name="lewo" />
        <signal name="prawo" />
        <port polarity="Input" name="zegar" />
        <port polarity="Output" name="VGA_HS" />
        <port polarity="Output" name="VGA_VS" />
        <port polarity="Output" name="VGA_R" />
        <port polarity="Output" name="VGA_G" />
        <port polarity="Output" name="VGA_B" />
        <port polarity="Input" name="lewo" />
        <port polarity="Input" name="prawo" />
        <blockdef name="VGAtxt48x20">
            <timestamp>2024-4-16T13:56:36</timestamp>
            <rect width="304" x="64" y="-640" height="728" />
            <rect width="64" x="0" y="-620" height="24" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-448" y2="-448" x1="64" />
            <line x2="0" y1="-384" y2="-384" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="64" y2="64" x1="64" />
            <line x2="0" y1="0" y2="0" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-608" y2="-608" x1="368" />
            <line x2="432" y1="-544" y2="-544" x1="368" />
            <line x2="432" y1="-480" y2="-480" x1="368" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
        </blockdef>
        <blockdef name="buf">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <blockdef name="kod_better">
            <timestamp>2024-4-30T15:53:19</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="VGAtxt48x20" name="XLXI_2">
            <blockpin signalname="XLXN_7(7:0)" name="Char_DI(7:0)" />
            <blockpin name="Home" />
            <blockpin name="NewLine" />
            <blockpin name="Goto00" />
            <blockpin signalname="zegar" name="Clk_Sys" />
            <blockpin signalname="zegar" name="Clk_50MHz" />
            <blockpin name="CursorOn" />
            <blockpin name="ScrollEn" />
            <blockpin name="ScrollClear" />
            <blockpin name="Busy" />
            <blockpin signalname="VGA_HS" name="VGA_HS" />
            <blockpin signalname="VGA_VS" name="VGA_VS" />
            <blockpin signalname="XLXN_4" name="VGA_RGB" />
            <blockpin signalname="XLXN_5" name="Char_WE" />
        </block>
        <block symbolname="buf" name="XLXI_3">
            <blockpin signalname="XLXN_4" name="I" />
            <blockpin signalname="VGA_R" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_4">
            <blockpin signalname="XLXN_4" name="I" />
            <blockpin signalname="VGA_G" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="XLXN_4" name="I" />
            <blockpin signalname="VGA_B" name="O" />
        </block>
        <block symbolname="kod_better" name="XLXI_32">
            <blockpin signalname="zegar" name="zegar" />
            <blockpin signalname="lewo" name="lewo" />
            <blockpin signalname="prawo" name="prawo" />
            <blockpin signalname="XLXN_5" name="znak_gotowy" />
            <blockpin name="go_to_beginning" />
            <blockpin signalname="XLXN_7(7:0)" name="znak(7:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="zegar">
            <wire x2="432" y1="800" y2="800" x1="208" />
            <wire x2="656" y1="800" y2="800" x1="432" />
            <wire x2="432" y1="800" y2="1312" x1="432" />
            <wire x2="1056" y1="1312" y2="1312" x1="432" />
            <wire x2="1456" y1="1312" y2="1312" x1="1056" />
            <wire x2="1056" y1="1312" y2="1376" x1="1056" />
            <wire x2="1456" y1="1376" y2="1376" x1="1056" />
        </branch>
        <instance x="1456" y="1312" name="XLXI_2" orien="R0">
        </instance>
        <branch name="VGA_HS">
            <wire x2="2048" y1="704" y2="704" x1="1888" />
        </branch>
        <branch name="VGA_VS">
            <wire x2="2048" y1="768" y2="768" x1="1888" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="2080" y1="832" y2="832" x1="1888" />
            <wire x2="2176" y1="832" y2="832" x1="2080" />
            <wire x2="2080" y1="832" y2="976" x1="2080" />
            <wire x2="2208" y1="976" y2="976" x1="2080" />
            <wire x2="2080" y1="976" y2="1136" x1="2080" />
            <wire x2="2256" y1="1136" y2="1136" x1="2080" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1056" y1="800" y2="800" x1="1040" />
            <wire x2="1248" y1="800" y2="800" x1="1056" />
            <wire x2="1248" y1="768" y2="800" x1="1248" />
            <wire x2="1456" y1="768" y2="768" x1="1248" />
        </branch>
        <branch name="XLXN_7(7:0)">
            <wire x2="1056" y1="928" y2="928" x1="1040" />
            <wire x2="1232" y1="928" y2="928" x1="1056" />
            <wire x2="1232" y1="704" y2="928" x1="1232" />
            <wire x2="1456" y1="704" y2="704" x1="1232" />
        </branch>
        <iomarker fontsize="28" x="208" y="800" name="zegar" orien="R180" />
        <iomarker fontsize="28" x="2048" y="704" name="VGA_HS" orien="R0" />
        <iomarker fontsize="28" x="2048" y="768" name="VGA_VS" orien="R0" />
        <instance x="2176" y="864" name="XLXI_3" orien="R0" />
        <instance x="2208" y="1008" name="XLXI_4" orien="R0" />
        <instance x="2256" y="1168" name="XLXI_5" orien="R0" />
        <branch name="VGA_R">
            <wire x2="2480" y1="832" y2="832" x1="2400" />
        </branch>
        <branch name="VGA_G">
            <wire x2="2480" y1="976" y2="976" x1="2432" />
        </branch>
        <branch name="VGA_B">
            <wire x2="2528" y1="1136" y2="1136" x1="2480" />
        </branch>
        <iomarker fontsize="28" x="2480" y="832" name="VGA_R" orien="R0" />
        <iomarker fontsize="28" x="2480" y="976" name="VGA_G" orien="R0" />
        <iomarker fontsize="28" x="2528" y="1136" name="VGA_B" orien="R0" />
        <branch name="lewo">
            <wire x2="656" y1="864" y2="864" x1="304" />
        </branch>
        <branch name="prawo">
            <wire x2="656" y1="928" y2="928" x1="288" />
        </branch>
        <iomarker fontsize="28" x="304" y="864" name="lewo" orien="R180" />
        <iomarker fontsize="28" x="288" y="928" name="prawo" orien="R180" />
        <instance x="656" y="960" name="XLXI_32" orien="R0">
        </instance>
    </sheet>
</drawing>