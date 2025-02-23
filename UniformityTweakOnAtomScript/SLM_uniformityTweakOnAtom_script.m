%% This script is used to compute the measured trap non-uniformity, prepared for WGS 
% uniformity tweak
data = NaCsData('20220221','121446', 'C:\Users\Aki_F\Postdoc project\matlab_seq\experiment-control\data\');
%%
data = NaCsData('20220221','134650','N:\NaCsLab\Data\');
%%
data = NaCsData('20220221','191952','N:\NaCsLab\Data\');
%%
data = NaCsData('20220221','203512','N:\NaCsLab\Data\');
%%
data = NaCsData('20220222','102011','N:\NaCsLab\Data\');
%% 
CsArray = CsArrayData(data);
%%
dip=ones(1,36)*25;
trap = TrapFitting_AutoTune_v2(data, 36, dip);
%% fit one site
dip = 28;
site = 31;
trap_site = TrapFitting_AutoTune_site_v2(data,site,dip);
%%
%trap = trap_sites;
Inten = trap.trapInt';
Inten_nooffset = Inten-13.53;
IntenCenter = trap.trapCenterVal;
%%
Inten_nooffset(19)=15;
Inten_nooffset(25)=15;
%%
Inten_nooffset(31)=28.5-13.53;
Inten_nooffset(2)=12;
Inten_nooffset(15)=13;
%%
h=figure(200);clf;
plot(IntenCenter, Inten_nooffset, 'ro', 'Linewidth', 1.5);
xlabel('Dip survival');
ylabel('Light shifts (MHZ)');
%axis([0 1 5 20]);
nacstools.display.makePretty(h, 'width', 15, 'height', 10, 'textFontSize', 12, 'axisFontSize', 12);
%%
h=figure(202);clf;
plot(site, IntenCenter, 'ro', 'Linewidth', 1.5);
xlabel('site');
ylabel('Center dip');
%axis([0 1 5 20]);
nacstools.display.makePretty(h, 'width', 15, 'height', 10, 'textFontSize', 12, 'axisFontSize', 12);
%%
site = 1:36;
figure(201);clf;
plot(site, Inten_nooffset, 'bo', 'Linewidth', 1.5);
xlabel('site');
ylabel('Light shifts (MHZ)');
%axis([0 1 5 20]);
nacstools.display.makePretty(h, 'width', 15, 'height', 10, 'textFontSize', 12, 'axisFontSize', 12);
%%
Inten_Onatom = Inten_nooffset/sum(Inten_nooffset)
%%
(var(Inten_Onatom))^0.5/mean(Inten_Onatom)
%%
csvwrite('trapInt_norm_onAtom_R2_0221.csv', Inten_Onatom)