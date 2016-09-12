global margin_x margin_y;
global frame_w frame_h plot_w plot_h;
// Window Parameters initialization
frame_w = 200+500; frame_h = 580;// Frame width and height
plot_w = 150; plot_h = frame_h;// Plot width and heigh
margin_x = 5; margin_y = 5;// Horizontal and vertical margin
//for elements
defaultfont = "arial"; // Default Font
//axes_w = 2*margin_x + frame_w + plot_w;// axes width
//axes_h = 2*margin_y + frame_h; // axes height (100 =>
//toolbar height)
demo_lhy = scf(100001);// Create window with id=100001 and make
//it the current one
// Background and text
demo_lhy.background = -2;
demo_lhy.figure_position = [100 0];
demo_lhy.figure_name = gettext("Control System");
// Change dimensions of the figure
demo_lhy.axes_size = [1100 610]; 

//demo_lhy.axes_size = [1320 600];
//demo_lhy.figure_size = [-1 -1];
// Remove Scilab graphics menus & toolbar
delmenu(demo_lhy.figure_id,gettext("&File"));
delmenu(demo_lhy.figure_id,gettext("&Tools"));
delmenu(demo_lhy.figure_id,gettext("&Edit"));
delmenu(demo_lhy.figure_id,gettext("&?"));
toolbar(demo_lhy.figure_id,"off");
// New menu
h1 = uimenu("parent",demo_lhy, "label",gettext("File"));

h3 = uimenu("parent",demo_lhy, "label",gettext("Response"));
h4 = uimenu("parent",demo_lhy, "label",gettext("Parameters"));
h2 = uimenu("parent",demo_lhy, "label",gettext("About"));
// Populate menu: file
uimenu(h1, "label",gettext("Close"), 'callback',"demo_lhy=get_figure_handle(100001);delete(demo_lhy);");
uimenu(h2, "label",gettext("About"),"callback","About();");
popul1=uimenu(h3, "label",gettext("Plots"),"callback","plt();");
popul2=uimenu(h3, "label",gettext("Margin"),"callback","mrgin();");
popul3=uimenu(h4,"label",gettext("PZdata"),"callback","PZdata();");
popul3=uimenu(h4,"label",gettext("Systemdata"),"callback","Systemdata();");
//sleep(500);

//--------------------------------------outer- dhacha uptill here--------------------------------------------------------------//


my_frame = uicontrol("parent",demo_lhy, "relief","groove","style","frame", "units","pixels","position",[5 5 500 600],"horizontalalignment","center", "background",[1 1 1],"tag","frame_control");
//_______________outer box frame LHS-----------//////////

//my_frame_title = uicontrol("parent",demo_lhy, "style","text","string","System", "units","pixels","position",[70+margin_x margin_y+frame_h-10 frame_w-60 20],"fontname",defaultfont, "fontunits","points","fontsize",16, "horizontalalignment","center","background",[1 1 1], "tag","title_frame_control"); 

///////----------numerator & den ka edit box---------////////////
textsys1 = uicontrol("parent",demo_lhy,"relief","groove","style","edit","units","pixels","position",[margin_x+100 500 400-70 30],"tag","nter1");
textsys2 = uicontrol("parent",demo_lhy,"relief","groove","style","edit","units","pixels","position",[margin_x+100 450 400-70 30],"tag","nter2");

//////////-----numerator & denominator ka text------------//
dispnum = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Numerator","position",[margin_x+3 500 95 30]);
dispden = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Denominator","position",[margin_x+3 450 95 30]);


//________________________________system attributes left ----------------------//

//____________text boxes left attributes____________________//
dispsys = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","System","position",[margin_x+3 400-50-50 95 60]);
disppol = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Poles","position",[margin_x+3 350-50-50 95 30]);
dispzer = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Zeros","position",[margin_x+3 300-50-50 95 30]);
dispgain = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Gain","position",[margin_x+3 250-50-50 95 30]);
dispstab = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Stability","position",[margin_x+3 200-50-50 95 30]);
dispsysa = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 400-50-50 400-70 60],"tag","sysa");
disppola = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 350-50-50 400-70 30],"tag","pola");
dispzera = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 300-50-50 400-70 30],"tag","zera");
dispgaina = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 250-50-50 400-70 30],"tag","gaina");
dispstaba = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 200-50-50 400-70 30],"tag","staba");
//__________________________________________________________________________________________________________________________________________________//



//_____________Button to enter to kae action_______________//
enter = uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+100+330+5 450 60 80],"string","ENTER","callback","enter();"); 
//______________________________________________________________________//

//left layout ends here-_____________________//




//Right layout starts here-///////-------------------------------------------





//Right layout ends here-///////////////-------------------------------------



//Functions---------------------------------------//
function enter()

    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);

    sys=syslin('c',sys);
    //  disp(typeof(sys1))
    textsys = findobj("tag","sysa");textsys.string=string(syst);
endfunction



function plt()
    tag1 = findobj("tag","p1");
    tag1.visible="off"
    tag1 = findobj("tag","p2");
    tag1.visible="off"
    tag1 = findobj("tag","p3");
    tag1.visible="off"
    tag1 = findobj("tag","p4");
    tag1.visible="off"
    tag2 = findobj("tag","margin1");
    tag2.visible="off"
    tag2 = findobj("tag","margin2");
    tag2.visible="off"
     tag1 = findobj("tag","p5");
    tag1.visible="off"
     tag1 = findobj("tag","p6");
    tag1.visible="off"
     tag1 = findobj("tag","p7");
    tag1.visible="off"
    
    impls=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 300-50-50 330 40],"tag","impuls","string","impulse","callback","impuls();");
   
    inital=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 80 330 40],"tag","impuls1","string","Sigma","callback","sig();");
   iop= uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 330 40],"tag","impuls2","string","iopzplot","callback","iopz();");
    implsi=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 300-50-50 20 40],"tag","impulsi","string","?","callback","knowimpulse();");
   
    initali=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 80 20 40],"tag","impuls1i","string","?","callback","knowsigma();");
   iopi= uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","impuls2i","string","?","callback","knowiopz();");
endfunction

function impuls()  
   
   
    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
     sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
   
    plot1 = scf(100002);
    plot1.background = -2;
    plot1.figure_position = [680 70];
    plot1.axes_size = [500 220];
    demo_lhy1.figure_name = gettext("IMPULSE PLOT");
    impulse(sys);
    hh=gca();
    hh.auto_clear="on"

endfunction

//Please put left hand attributes function below this-------------------//



















