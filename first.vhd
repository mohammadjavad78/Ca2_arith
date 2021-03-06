
library ieee;
use ieee.std_logic_1164.all;

entity HZ is
  port (
    X,Y:in std_logic_vector(1 downto 0);
    H:out std_logic;
    Z:out std_logic_vector(1 downto 0)
  ) ;
end HZ ; 

architecture arch of HZ is

begin
    H<=( (not(X(1))) and ( not(Y(1)) ) and (Y(0)) )  or  ( (not(X(1))) and (X(0)) and (not(Y(1))) );
    Z(1)<=( (X(0)) and (not(Y(0))) ) or ( (not(X(0))) and (Y(0)) ) or ( (X(1)) and (Y(1)) );
    Z(0)<=( (X(0)) and (not(Y(0))) )  or ( (not(X(0))) and (Y(0)));
end architecture ;



library ieee;
use ieee.std_logic_1164.all;

entity TW is
  port (
    Q:in std_logic_vector(1 downto 0);
    W:out std_logic;
    T:out std_logic_vector(1 downto 0)
  ) ;
end TW ; 

architecture arch of TW is

begin
  T(1)<=Q(1);
  T(0)<=Q(1);
  W<=Q(0);
end architecture ;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
entity adder is
  port (
    A:in std_logic_vector(1 downto 0);
    B:in std_logic;
    O:out std_logic_vector(1 downto 0)
  ) ;
end adder ; 

architecture arch of adder is
begin
  O<=A+('0'&B);
end architecture ;


library ieee ;
    use ieee.std_logic_1164.all ;
entity Signed_digit is
  generic (bits:integer:=1);
  port (
    X1,X0,Y1,Y0:in std_logic_vector(bits-1 downto 0);
    S1,S0:out std_logic_vector(bits downto 0)
  ) ;
end Signed_digit ; 

architecture arch of Signed_digit is
  type sd is array (bits-1 downto 0) of std_logic_vector(1 downto 0);
  type sd2 is array (bits downto 0) of std_logic_vector(1 downto 0);
  type sd3 is array (bits+1 downto 0) of std_logic_vector(1 downto 0);
  signal ZZ:sd2;
  signal QQ:sd2;
  signal XX:sd;
  signal YY:sd;
  signal h:std_logic_vector(bits downto 0);
  signal W:std_logic_vector(bits downto 0);
  signal TT:sd3;
  signal SS:sd2;
begin
  ZZ(bits)<="00";
  h(0)<='0';
  TT(0)<="00";
  initial:for i in 0 to bits-1 generate
  begin
    XX(i)<=(X1(i)&X0(i));
    YY(i)<=(Y1(i)&Y0(i));
  end generate;
  initial2:for i in 0 to bits generate
  begin
    S1(i)<=SS(i)(1);
    S0(i)<=SS(i)(0);
  end generate;
  unit1:for i in 0 to bits-1 generate
  begin
    uu:entity work.HZ(arch) port map(X=>XX(i),Y=>YY(i),H=>h(i+1),Z=>ZZ(i));
  end generate;
  unit2:for i in 0 to bits generate
  begin
    uu2:entity work.Adder(arch) port map(A=>ZZ(i),B=>h(i),O=>QQ(i));
  end generate;
  unit3:for i in 0 to bits generate
  begin
    uu3:entity work.TW(arch) port map(Q=>QQ(i),W=>W(i),T=>TT(i+1));
  end generate;
  unit4:for i in 0 to bits generate
  begin
    uu4:entity work.Adder(arch) port map(A=>TT(i),B=>W(i),O=>SS(i));
  end generate;
end architecture ;

