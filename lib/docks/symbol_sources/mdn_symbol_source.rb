require_relative "base_symbol_source.rb"
require_relative "../languages.rb"

module Docks
  module SymbolSources
    class MDN < Base
      GLOBAL_SYMBOLS = %w(
        object function boolean symbol number date string regexp map set weakmap weakset arguments undefined
        error evalerror internalerror rangeerror referenceerror syntaxerror typeerror urierror
        array int8array uint8array uint8clampedarray int16array uint16array int32array uint32array float32array float64array
        promise generator generatorfunction proxy iterator
      )

      WEB_API_SYMBOLS = %w(
        abstractworker analysernode animationevent animationplayer apps.mgmt arraybufferview attr audiobuffer audiobuffersourcenode audiochannelmanager audiocontext audiodestinationnode audiolistener audionode audioparam audioprocessingevent batterymanager beforeinstallpromptevent beforeunloadevent biquadfilternode blob blobbuilder blobevent bluetoothadapter bluetoothdevice bluetoothdeviceevent bluetoothmanager bluetoothstatuschangedevent body broadcastchannel bytestring cdatasection css cssconditionrule csscounterstylerule cssgroupingrule csskeyframerule csskeyframesrule cssmatrix cssmediarule cssnamespacerule csspagerule cssrule cssrulelist cssstyledeclaration cssstylerule cssstylesheet csssupportsrule cache cachestorage callevent cameracapabilities cameracontrol cameramanager canvasgradient canvasimagesource canvaspattern canvasrenderingcontext2d caretposition channelmergernode channelsplitternode characterdata childnode chromeworker client clients clipboardevent closeevent comment compositionevent connection console contactmanager convolvernode coordinates crypto cryptokey customevent domapplication domapplicationsmanager domapplicationsregistry domconfiguration domcursor domerror domerrorhandler domexception domhighrestimestamp domimplementation domimplementationlist domimplementationregistry domimplementationsource domlocator dommatrix dommatrixreadonly domobject domparser dompoint dompointreadonly domrect domrectreadonly domrequest domstring domstringlist domstringmap domtimestamp domtokenlist domuserdata datastore datastorechangeevent datastorecursor datastoretask datatransfer dedicatedworkerglobalscope delaynode deviceacceleration devicelightevent devicemotionevent deviceorientationevent deviceproximityevent devicerotationrate devicestorage devicestoragechangeevent directoryentry directoryentrysync directoryreader directoryreadersync document documentfragment documenttouch documenttype dragevent dynamicscompressornode element elementtraversal encryptedmediaextensions api entity entityreference entry entrysync errorevent event eventlistener eventsource eventtarget extendableevent fmradio fetchevent file fileentry fileentrysync fileerror fileexception filehandle filelist filereader filereadersync filerequest filesystem filesystemsync focusevent formdata gainnode gamepad gamepadbutton gamepadevent geolocation globaleventhandlers globalfetch hmdvrdevice htmlanchorelement htmlareaelement htmlaudioelement htmlbrelement htmlbaseelement htmlbasefontelement htmlbodyelement htmlbuttonelement htmlcanvaselement htmlcollection htmlcontentelement htmldlistelement htmldataelement htmldatalistelement htmldialogelement htmldivelement htmldocument htmlelement htmlembedelement htmlfieldsetelement htmlformcontrolscollection htmlformelement htmlframesetelement htmlhrelement htmlheadelement htmlheadingelement htmlhtmlelement htmliframeelement htmlimageelement htmlinputelement htmlisindexelement htmlkeygenelement htmllielement htmllabelelement htmllegendelement htmllinkelement htmlmapelement htmlmediaelement htmlmetaelement htmlmeterelement htmlmodelement htmlolistelement htmlobjectelement htmloptgroupelement htmloptionelement htmloptionscollection htmloutputelement htmlparagraphelement htmlparamelement htmlpictureelement htmlpreelement htmlprogresselement htmlquoteelement htmlscriptelement htmlselectelement htmlshadowelement htmlsourceelement htmlspanelement htmlstyleelement htmltablecaptionelement htmltablecellelement htmltablecolelement htmltabledatacellelement htmltableelement htmltableheadercellelement htmltablerowelement htmltablesectionelement htmltextareaelement htmltimeelement htmltitleelement htmltrackelement htmlulistelement htmlunknownelement htmlvideoelement hashchangeevent headers history idbcursor idbcursorsync idbcursorwithvalue idbdatabase idbdatabaseexception idbdatabasesync idbenvironment idbenvironmentsync idbfactory idbfactorysync idbindex idbindexsync idbkeyrange idbobjectstore idbobjectstoresync idbopendbrequest idbrequest idbtransaction idbtransactionsync idbversionchangeevent idbversionchangerequest identitymanager imagedata index inputevent installevent keyboardevent l10n.formatvalue l10n.get l10n.language.code l10n.language.direction l10n.once l10n.ready l10n.readystate l10n.setattributes linkstyle localfilesystem localfilesystemsync localmediastream location lockedfile midiaccess midiconnectionevent midiinput midiinputmap mediadevices mediaelementaudiosourcenode mediakeymessageevent mediakeysession mediakeystatusmap mediakeysystemaccess mediakeysystemconfiguration mediakeys mediaquerylist mediaquerylistlistener mediarecorder mediasource mediastream mediastreamaudiodestinationnode mediastreamaudiosourcenode mediastreamevent mediastreamtrack messagechannel messageevent messageport mouseevent mousescrollevent mousewheelevent mozactivity mozactivityoptions mozactivityrequesthandler mozalarmsmanager mozcontact mozcontactchangeevent moziccmanager mozmmsevent mozmmsmessage mozmobilecfinfo mozmobilecellinfo mozmobileconnection mozmobileconnectioninfo mozmobileiccinfo mozmobilemessagemanager mozmobilemessagethread mozmobilenetworkinfo mozndefrecord moznfc moznfcpeer moznfctag moznetworkstats moznetworkstatsdata moznetworkstatsmanager mozsettingsevent mozsmsevent mozsmsfilter mozsmsmanager mozsmsmessage mozsmssegmentinfo mozsocial moztimemanager mozvoicemail mozvoicemailevent mozvoicemailstatus mozwificonnectioninfoevent mozwifip2pgroupowner mozwifip2pmanager mozwifistatuschangeevent mutationevent mutationobserver namelist namednodemap navigator navigatorgeolocation navigatorid navigatorlanguage navigatoronline navigatorplugins networkinformation node nodefilter nodeiterator nodelist nondocumenttypechildnode notation notification notifyaudioavailableevent offlineaudiocompletionevent offlineaudiocontext oscillatornode pagetransitionevent pannernode parentnode path2d performance performancenavigation performancetiming periodicsyncevent periodicsyncmanager periodicsyncregistration periodicwave permissionsettings permissionstatus permissions plugin pluginarray point popstateevent portcollection position positionerror positionoptions positionsensorvrdevice powermanager processinginstruction progressevent promiseresolver pushevent pushmanager pushsubscription rtcconfiguration rtcdatachannel rtcdatachannelevent rtcidentityerrorevent rtcidentityevent rtcpeerconnection rtcpeerconnectioniceevent rtcsessiondescription rtcsessiondescriptioncallback radionodelist randomsource range renderingcontext request response svgaelement svgangle svganimatecolorelement svganimateelement svganimatemotionelement svganimatetransformelement svganimatedangle svganimatedboolean svganimatedenumeration svganimatedinteger svganimatedlength svganimatedlengthlist svganimatednumber svganimatednumberlist svganimatedpoints svganimatedpreserveaspectratio svganimatedrect svganimatedstring svganimatedtransformlist svganimationelement svgcircleelement svgclippathelement svgcursorelement svgdefselement svgdescelement svgelement svgellipseelement svgevent svgfilterelement svgfontelement svgfontfaceelement svgfontfaceformatelement svgfontfacenameelement svgfontfacesrcelement svgfontfaceurielement svgforeignobjectelement svggelement svgglyphelement svggradientelement svghkernelement svgimageelement svglength svglengthlist svglineelement svglineargradientelement svgmpathelement svgmaskelement svgmatrix svgmissingglyphelement svgnumber svgnumberlist svgpathelement svgpatternelement svgpoint svgpolygonelement svgpolylineelement svgpreserveaspectratio svgradialgradientelement svgrect svgrectelement svgsvgelement svgscriptelement svgsetelement svgstopelement svgstringlist svgstylable svgstyleelement svgswitchelement svgsymbolelement svgtrefelement svgtspanelement svgtests svgtextelement svgtextpositioningelement svgtitleelement svgtransform svgtransformlist svgtransformable svguseelement svgvkernelement svgviewelement screen scriptprocessornode selection serviceworker serviceworkercontainer serviceworkerglobalscope serviceworkerregistration settingslock settingsmanager sharedworker sharedworkerglobalscope stereopannernode storage storageevent stylesheet stylesheetlist subtlecrypto syncevent syncmanager syncregistration tcpserversocket tcpsocket telephony telephonycall text textdecoder textencoder textmetrics timeevent timeranges touch touchevent touchlist transferable transitionevent treewalker typeinfo uievent url urlsearchparams urlutils urlutilsreadonly usvstring userdatahandler userproximityevent vrdevice vreyeparameters vrfieldofview vrfieldofviewreadonly vrpositionstate validitystate videoplaybackquality waveshapernode webglrenderingcontext websocket wheelevent wifimanager window windowbase64 windowclient windoweventhandlers windoweventhandlers.onbeforeprint windowtimers worker workerglobalscope workerlocation workernavigator xdomainrequest xmldocument xmlhttprequest xmlhttprequesteventtarget
      )

      GLOBAL_SYMBOL_URL = "https://developer.mozilla.org/docs/Web/JavaScript/Reference/Global_Objects"
      WEB_API_SYMBOL_URL = "https://developer.mozilla.org/docs/Web/API"

      def recognizes?(symbol, options = {})
        language = options.fetch(:language, nil)
        return false if language && Languages.file_type(language) != Types::Languages::SCRIPT

        symbol = symbol.to_s.downcase
        GLOBAL_SYMBOLS.include?(symbol) || WEB_API_SYMBOLS.include?(symbol)
      end

      def path_for(symbol)
        return "#{GLOBAL_SYMBOL_URL}/#{symbol}" if GLOBAL_SYMBOLS.include?(symbol.downcase.to_s)
        "#{WEB_API_SYMBOL_URL}/#{symbol}"
      end
    end
  end
end
