<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="zegar" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5(7:0)" />
        <signal name="XLXN_6" />
        <signal name="VGA_VS" />
        <signal name="VGA_HS" />
        <signal name="lewo" />
        <signal name="prawo" />
        <signal name="VGA_R" />
        <signal name="VGA_G" />
        <signal name="VGA_B" />
        <port polarity="Input" name="zegar" />
        <port polarity="Output" name="VGA_VS" />
        <port polarity="Output" name="VGA_HS" />
        <port polarity="Input" name="lewo" />
        <port polarity="Input" name="prawo" />
        <port polarity="Output" name="VGA_R" />
        <port polarity="Output" name="VGA_G" />
        <port polarity="Output" name="VGA_B" />
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
        <block symbolname="VGAtxt48x20" name="XLXI_2">
            <blockpin signalname="XLXN_5(7:0)" name="Char_DI(7:0)" />
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
            <blockpin signalname="XLXN_6" name="VGA_RGB" />
            <blockpin signalname="XLXN_4" name="Char_WE" />
        </block>
        <block symbolname="buf" name="XLXI_3">
            <blockpin signalname="XLXN_6" name="I" />
            <blockpin signalname="VGA_R" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_4">
            <blockpin signalname="XLXN_6" name="I" />
            <blockpin signalname="VGA_G" name="O" />
        </block>
        <block symbolname="buf" name="XLXI_5">
            <blockpin signalname="XLXN_6" name="I" />
            <blockpin signalname="VGA_B" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2016" y="1568" name="XLXI_2" orien="R0">
        </instance>
        <branch name="zegar">
            <wire x2="496" y1="1040" y2="1040" x1="416" />
            <wire x2="944" y1="1040" y2="1040" x1="496" />
            <wire x2="496" y1="1040" y2="1568" x1="496" />
            <wire x2="1152" y1="1568" y2="1568" x1="496" />
            <wire x2="2016" y1="1568" y2="1568" x1="1152" />
            <wire x2="1152" y1="1568" y2="1632" x1="1152" />
            <wire x2="2016" y1="1632" y2="1632" x1="1152" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1664" y1="1040" y2="1040" x1="1328" />
            <wire x2="1664" y1="1024" y2="1040" x1="1664" />
            <wire x2="2016" y1="1024" y2="1024" x1="1664" />
        </branch>
        <branch name="XLXN_5(7:0)">
            <wire x2="1648" y1="1168" y2="1168" x1="1328" />
            <wire x2="1648" y1="960" y2="1168" x1="1648" />
            <wire x2="2016" y1="960" y2="960" x1="1648" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="2608" y1="1088" y2="1088" x1="2448" />
            <wire x2="2608" y1="1088" y2="1280" x1="2608" />
            <wire x2="2608" y1="1280" y2="1424" x1="2608" />
            <wire x2="2688" y1="1424" y2="1424" x1="2608" />
            <wire x2="2688" y1="1280" y2="1280" x1="2608" />
            <wire x2="2704" y1="1088" y2="1088" x1="2608" />
        </branch>
        <branch name="VGA_VS">
            <wire x2="2832" y1="1024" y2="1024" x1="2448" />
            <wire x2="2832" y1="960" y2="1024" x1="2832" />
        </branch>
        <branch name="VGA_HS">
            <wire x2="2672" y1="960" y2="960" x1="2448" />
            <wire x2="2672" y1="800" y2="960" x1="2672" />
        </branch>
        <branch name="lewo">
            <wire x2="944" y1="1104" y2="1104" x1="192" />
        </branch>
        <branch name="prawo">
            <wire x2="944" y1="1168" y2="1168" x1="192" />
        </branch>
        <iomarker fontsize="28" x="416" y="1040" name="zegar" orien="R180" />
        <iomarker fontsize="28" x="192" y="1104" name="lewo" orien="R180" />
        <iomarker fontsize="28" x="192" y="1168" name="prawo" orien="R180" />
        <iomarker fontsize="28" x="2832" y="960" name="VGA_VS" orien="R270" />
        <iomarker fontsize="28" x="2672" y="800" name="VGA_HS" orien="R270" />
        <instance x="2704" y="1120" name="XLXI_3" orien="R0" />
        <instance x="2688" y="1312" name="XLXI_4" orien="R0" />
        <instance x="2688" y="1456" name="XLXI_5" orien="R0" />
        <branch name="VGA_R">
            <wire x2="2960" y1="1088" y2="1088" x1="2928" />
        </branch>
        <iomarker fontsize="28" x="2960" y="1088" name="VGA_R" orien="R0" />
        <branch name="VGA_G">
            <wire x2="2944" y1="1280" y2="1280" x1="2912" />
        </branch>
        <iomarker fontsize="28" x="2944" y="1280" name="VGA_G" orien="R0" />
        <branch name="VGA_B">
            <wire x2="2944" y1="1424" y2="1424" x1="2912" />
        </branch>
        <iomarker fontsize="28" x="2944" y="1424" name="VGA_B" orien="R0" />
    </sheet>
</drawing>