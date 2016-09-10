//    sys=1/(s+2+s^3)
//    sys=((s+3)*(s))/(s+2+s^4)
//    sys=(s+4)/(s^2+8*s+9)


global margin_x margin_y;
global frame_w frame_h plot_w plot_h;
// Window Parameters initialization
frame_w = 200; frame_h = 550;// Frame width and height
plot_w = 150; plot_h = frame_h;// Plot width and heigh
margin_x = 150; margin_y = 15;// Horizontal and vertical margin
//for elements
defaultfont = "arial"; // Default Font
axes_w = 2*margin_x + frame_w + plot_w;// axes width
axes_h = 2*margin_y + frame_h; // axes height (100 =>
//toolbar height)
demo_lhy = scf(100001);// Create window with id=100001 and make
//it the current one
// Background and text
demo_lhy.background = -2;
demo_lhy.figure_position = [100 100];
demo_lhy.figure_name = gettext("Control System");
// Change dimensions of the figure
demo_lhy.axes_size = [axes_w axes_h]; 

// Remove Scilab graphics menus & toolbar
delmenu(demo_lhy.figure_id,gettext("&File"));
delmenu(demo_lhy.figure_id,gettext("&Tools"));
delmenu(demo_lhy.figure_id,gettext("&Edit"));
delmenu(demo_lhy.figure_id,gettext("&?"));
toolbar(demo_lhy.figure_id,"off");
// New menu
h1 = uimenu("parent",demo_lhy, "label",gettext("File"));
h2 = uimenu("parent",demo_lhy, "label",gettext("About"));
h3 = uimenu("parent",demo_lhy, "label",gettext("Response"));
h4 = uimenu("parent",demo_lhy, "label",gettext("Parameters"));
// Populate menu: file
uimenu(h1, "label",gettext("Close"), 'callback',"demo_lhy=get_figure_handle(100001);delete(demo_lhy);");
// Populate menu: about
uimenu(h2, "label",gettext("About"),"callback","About();");
popul1=uimenu(h3, "label",gettext("Plots"),"callback","plt();");
popul2=uimenu(h3, "label",gettext("Margin"),"callback","mrgin();");
popul3=uimenu(h4,"label",gettext("PZdata"),"callback","PZdata();");
popul3=uimenu(h4,"label",gettext("Systemdata"),"callback","Systemdata();");
// Sleep to guarantee a better display (avoiding to see a
//sequential display)
sleep(500); 



my_frame = uicontrol("parent",demo_lhy, "relief","groove","style","frame", "units","pixels","position",[margin_x margin_y frame_w+100 frame_h],"horizontalalignment","center", "background",[1 1 1],"tag","frame_control");

my_frame_title = uicontrol("parent",demo_lhy, "style","text","string","System", "units","pixels","position",[70+margin_x margin_y+frame_h-10 frame_w-60 20],"fontname",defaultfont, "fontunits","points","fontsize",16, "horizontalalignment","center","background",[1 1 1], "tag","title_frame_control"); 
textsys = uicontrol("parent",demo_lhy,"relief","groove","style","edit","units","pixels","position",[margin_x+60 500 frame_w-10 20],"tag","nter"); 
enter1 = uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+70 400 frame_w-50 40],"string","ENTER","callback","enter();"); 
dispplay=uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+50 250 frame_w-10 100],"tag","disp");
//handles.obj=newaxes();handles.obj.margin=[0 0 0 0];handles.obj.axes_bounds=[1/3,0,2/3,1]
function enter()

    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    //  disp(typeof(sys1))
    textsys = findobj("tag","disp");textsys.string=string(syst);
endfunction
////c=enter();

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
    
    impls=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 20 frame_w-10 40],"tag","impuls","string","impulse","callback","impuls();");
   
    inital=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 80 frame_w-10 40],"tag","impuls1","string","Sigma","callback","sig();");
   iop= uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 140 frame_w-10 40],"tag","impuls2","string","iopzplot","callback","iopz();");
endfunction
function mrgin()
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impuls1");
    tag1.visible="off"
    tag2 = findobj("tag","impuls2");
    tag2.visible="off"
    tag1 = findobj("tag","p1");
    tag1.visible="off"
    tag1 = findobj("tag","p2");
    tag1.visible="off"
    tag1 = findobj("tag","p3");
    tag1.visible="off"
    tag1 = findobj("tag","p4");
    tag1.visible="off"
     tag1 = findobj("tag","p5");
    tag1.visible="off"
     tag1 = findobj("tag","p6");
    tag1.visible="off"
     tag1 = findobj("tag","p7");
    tag1.visible="off"
    show_mrg=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 20 frame_w-10 40],"tag","margin1","string","Margin","callback","mgin();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 80 frame_w-10 40],"tag","bode1","string","Bode","callback","bde();");
endfunction

function impuls()  
   
   
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
   
    demo_lhy1 = scf(100002);
    demo_lhy1.background = -2;
    demo_lhy1.figure_position = [50 50];
    demo_lhy1.axes_size = [axes_w axes_h];
    demo_lhy1.figure_name = gettext("IMPULSE PLOT");
    impulse(sys);
    hh=gca();
    hh.auto_clear="on"

endfunction
function sig()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
//     set(gca(),"auto clear","on")
    demo_lhy1 = scf(100002);
    demo_lhy1.background = -2;
    demo_lhy1.figure_position = [50 50];
    demo_lhy1.axes_size = [axes_w axes_h];
    demo_lhy1.figure_name = gettext("SIGMA");
    sigma(sys);
    hh=gca();
    hh.auto_clear="on"
   
   
endfunction

function iopz()
     editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
//     set(gca(),"auto clear","on")
    demo_lhy1 = scf(100002);
    demo_lhy1.background = -2;
    demo_lhy1.figure_position = [50 50];
    demo_lhy1.axes_size = [axes_w axes_h];
    demo_lhy1.figure_name = gettext("IOPZPLOT");
    iopzplot(sys);
    hh=gca();
    hh.auto_clear="on"
   
endfunction

function mgin()
    //    if ~isempty(handles.obj.children); then
    //        delete(handles.obj.children)
    //    end
    
    
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    demo_lhy1 = scf(100002);
    demo_lhy1.background = -2;
    demo_lhy1.figure_position = [50 50];
    demo_lhy1.axes_size = [axes_w axes_h];
    demo_lhy1.figure_name = gettext("MARGIN");
    margin(sys)

endfunction
function bde()
//    if ~isempty(handles.obj.children); then
//        delete(handles.obj.children)
//    end
    impls.children.visible="off"
    iop.children.visible="off"
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    demo_lhy1 = scf(100002);
    demo_lhy1.background = -2;
    demo_lhy1.figure_position = [50 50];
    demo_lhy1.axes_size = [axes_w axes_h];
    demo_lhy1.figure_name = gettext("BODE");
    bode(sys)

endfunction



//------------------------------------------------------------------///-------------------------------------------------------------------------------------
function PZdata()
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impuls1");
    tag1.visible="off"
    tag1 = findobj("tag","impuls2");
    tag1.visible="off"
    tag2 = findobj("tag","margin1");
    tag2.visible="off"
    tag2 = findobj("tag","margin2");
    tag2.visible="off"
    tag1 = findobj("tag","p4");
    tag1.visible="off"
    tag1 = findobj("tag","p5");
    tag1.visible="off"
    tag1 = findobj("tag","p6");
    tag1.visible="off"
     tag1 = findobj("tag","p7");
    tag1.visible="off"
    
    
    
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 20 frame_w-10 40],"tag","p1","string","Pole","callback","pol();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 80 frame_w-10 40],"tag","p2","string","Zero","callback","zer();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 140 frame_w-10 40],"tag","p3","string","ZPK","callback","zpkdat();");
//////     uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 100 frame_w-10 40],"tag","zpkdata1","string","AllMargin","callback","allmargi();");
//////    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 140 frame_w-10 40],"tag","tfdata1","string","StepInfo","callback","stepinf();");

    
endfunction
function pol()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);
    sys=syslin('c',sys);
    poles=cell2mat(pole(sys))
    //disp(poles) ;
    len = size(poles,1) ;
    //disp(len)
    page = list() ;
    page($+1)=list(list([1 len+1],'frame','Poles'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(poles(i))));
        //disp('hello')
    end
    guimaker(page,list('Parameters')) ;
endfunction

function zer()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    zeroes  = (zero(sys)) ;
        //disp(poles) ;
    len = size(zeroes,1) ;
    //disp(len)
    page = list() ;
    page($+1)=list(list([1 len+1],'frame','Zeroes'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(zeroes(i))));
        //disp('hello')
    end
    guimaker(page,list('Parameters')) ;

endfunction
function zpkdat()
     editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    [a,b,c] = zpkdata(sys) ;
    [num, den] = tfdata(sys) ;
    page = list() ;
    page($+1)=list(list([1 2],'frame','Gain Matrix'));
    page($+1)=list(list('text','Gain'),list('edit',string(c)));
    len = length(num) ;
    page($+1)=list(list([1 len+1],'frame','Numerator'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(num(i))));
        //disp('hello')
    end
    len = length(den) ;
    page($+1)=list(list([1 len+1],'frame','Denominator'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(den(i))));
        //disp('hello')
    end
    guimaker(page,list('Parameters')) ;
    
    
endfunction

function Systemdata()
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impuls1");
    tag1.visible="off"
    tag1 = findobj("tag","impuls2");
    tag1.visible="off"
    tag2 = findobj("tag","margin1");
    tag2.visible="off"
    tag2 = findobj("tag","margin2");
    tag2.visible="off"
    tag1 = findobj("tag","p1");
    tag1.visible="off"
    tag1 = findobj("tag","p2");
    tag1.visible="off"
    tag1 = findobj("tag","p3");
    tag1.visible="off"
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 20 frame_w-10 40],"tag","p4","string","TFdata","callback","tfdat();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 80 frame_w-10 40],"tag","p5","string","Bandwidth","callback","bandwid();");
   uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 140 frame_w-10 40],"tag","p6","string","AllMargin","callback","allmargi();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+50 200 frame_w-10 40],"tag","p7","string","StepInfo","callback","stepinf();");

endfunction
function bandwid()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    band = bandwidth(sys) ;
    page = list() ;
    page($+1)=list(list([1 2],'frame','Bandwidth'));
    page($+1)=list(list('text','Bandwidth'),list('edit',string(band)));
    guimaker(page,list('Parameters')) ;
endfunction

function tfdat()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    [num, den] = tfdata(sys) ;
    page = list() ;
    len = length(num) ;
    page($+1)=list(list([1 len+1],'frame','Numerator'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(num(i))));
        //disp('hello')
    end
    len = length(den) ;
    page($+1)=list(list([1 len+1],'frame','Denominator'));
    for i =1:len 
        page($+1)=list(list('text',string(i)),list('edit',string(den(i))));
        //disp('hello')
    end
    guimaker(page,list('Parameters')) ;
endfunction

function stepinf()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    [x1 x2 x3 x4 x5 x6 x7 x8] = stepinfo(sys) ;
    page = list() ;
    page($+1)=list(list([1 8],'frame','Step Info'));
    page($+1)=list(list('text','Rise Time'),list('edit',string(x1)));
    page($+1)=list(list('text','Settling Time'),list('edit',string(x2)));
    page($+1)=list(list('text','Settling Minimum'),list('edit',string(x3)));
    page($+1)=list(list('text','Settling Maximum'),list('edit',string(x4)));
    page($+1)=list(list('text','Overshoot'),list('edit',string(x5)));
    page($+1)=list(list('text','Undershoot'),list('edit',string(x6)));
    page($+1)=list(list('text','Peak'),list('edit',string(x7)));
    page($+1)=list(list('text','Peak Time'),list('edit',string(x8)));
    guimaker(page,list('Parameters')) ;
endfunction
function allmargi()
    editsys = findobj("tag","nter");syst =(editsys.string);
    s=%s;
    sys=evstr(syst);

    sys=syslin('c',sys);
    a = allmargin(sys) ;
    x1 = a.GMF ;
    x2 = a.GM ;
    x3 = a.PMF ;
    x4 = a.PM ;
    x5 = a.DM ;
    x6 = a.DMF ;
    x7  =a.stable ;
    page = list() ;
    page($+1)=list(list([1 7],'frame','All Margin'));
    page($+1)=list(list('text','Gain Margin Frequency [rad/s]'),list('edit',string(x1)));
    page($+1)=list(list('text','Gain Margin [db]'),list('edit',string(x2)));
    page($+1)=list(list('text','Phase Margin Frequency [rad/s]'),list('edit',string(x3)));
    page($+1)=list(list('text','Phase Margin'),list('edit',string(x4)));
    page($+1)=list(list('text','Delay Margin'),list('edit',string(x5)));
    page($+1)=list(list('text','Delay Margin Frequency [rad/s]'),list('edit',string(x6)));
    page($+1)=list(list('text','Stable'),list('edit',string(x7)));
    guimaker(page,list('Parameters')) ;

endfunction
//--------------------------------------------------///--------------------------------------------------------------------------------------------------------

//
