/* 
   ORIGINALLY GENERATED BY XCI - see Common/Data/Input/h2cpp.pl 
   120302 THIS IS CUSTOM, we dont use h2cpp anymore because we load XCI from file everytime
   120604 added eventMinimapKey  number 66
 */
Text2Event_count = 0;
Text2Event[Text2Event_count++] = { TEXT("AbortTask"), &eventAbortTask };
Text2Event[Text2Event_count++] = { TEXT("AdjustForecastTemperature"), &eventAdjustForecastTemperature };
Text2Event[Text2Event_count++] = { TEXT("AdjustWaypoint"), &eventAdjustWaypoint };
Text2Event[Text2Event_count++] = { TEXT("Analysis"), &eventAnalysis };
Text2Event[Text2Event_count++] = { TEXT("ArmAdvance"), &eventArmAdvance };
Text2Event[Text2Event_count++] = { TEXT("Ballast"), &eventBallast };
Text2Event[Text2Event_count++] = { TEXT("Bugs"), &eventBugs };
Text2Event[Text2Event_count++] = { TEXT("Calculator"), &eventCalculator };
Text2Event[Text2Event_count++] = { TEXT("Checklist"), &eventChecklist };
Text2Event[Text2Event_count++] = { TEXT("DLLExecute"), &eventDLLExecute };
Text2Event[Text2Event_count++] = { TEXT("FlightMode"), &eventFlightMode };
Text2Event[Text2Event_count++] = { TEXT("Logger"), &eventLogger };
Text2Event[Text2Event_count++] = { TEXT("MacCready"), &eventMacCready };
Text2Event[Text2Event_count++] = { TEXT("MarkLocation"), &eventMarkLocation };
Text2Event[Text2Event_count++] = { TEXT("Mode"), &eventMode };
Text2Event[Text2Event_count++] = { TEXT("NearestAirspaceDetails"), &eventNearestAirspaceDetails };
Text2Event[Text2Event_count++] = { TEXT("NearestWaypointDetails"), &eventNearestWaypointDetails };
Text2Event[Text2Event_count++] = { TEXT("Null"), &eventNull };
Text2Event[Text2Event_count++] = { TEXT("Pan"), &eventPan };
Text2Event[Text2Event_count++] = { TEXT("PlaySound"), &eventPlaySound };
Text2Event[Text2Event_count++] = { TEXT("ProfileLoad"), &eventProfileLoad };
Text2Event[Text2Event_count++] = { TEXT("ProfileSave"), &eventProfileSave };
Text2Event[Text2Event_count++] = { TEXT("RepeatStatusMessage"), &eventRepeatStatusMessage };
Text2Event[Text2Event_count++] = { TEXT("Run"), &eventRun };
Text2Event[Text2Event_count++] = { TEXT("ScreenModes"), &eventScreenModes };
Text2Event[Text2Event_count++] = { TEXT("SendNMEA"), &eventSendNMEA };
Text2Event[Text2Event_count++] = { TEXT("SendNMEAPort1"), &eventSendNMEAPort1 };
Text2Event[Text2Event_count++] = { TEXT("SendNMEAPort2"), &eventSendNMEAPort2 };
Text2Event[Text2Event_count++] = { TEXT("Setup"), &eventSetup };
Text2Event[Text2Event_count++] = { TEXT("SnailTrail"), &eventSnailTrail };
Text2Event[Text2Event_count++] = { TEXT("VisualGlide"), &eventVisualGlide };
Text2Event[Text2Event_count++] = { TEXT("AirSpace"), &eventAirSpace };
Text2Event[Text2Event_count++] = { TEXT("Sounds"), &eventSounds };
Text2Event[Text2Event_count++] = { TEXT("Status"), &eventStatus };
Text2Event[Text2Event_count++] = { TEXT("StatusMessage"), &eventStatusMessage };
Text2Event[Text2Event_count++] = { TEXT("TaskLoad"), &eventTaskLoad };
Text2Event[Text2Event_count++] = { TEXT("TaskSave"), &eventTaskSave };
Text2Event[Text2Event_count++] = { TEXT("TerrainTopology"), &eventTerrainTopology };
Text2Event[Text2Event_count++] = { TEXT("WaypointDetails"), &eventWaypointDetails };
Text2Event[Text2Event_count++] = { TEXT("Wind"), &eventWind };
Text2Event[Text2Event_count++] = { TEXT("Zoom"), &eventZoom };
Text2Event[Text2Event_count++] = { TEXT("DeclutterLabels"), &eventDeclutterLabels };
Text2Event[Text2Event_count++] = { TEXT("Exit"), &eventExit };
Text2Event[Text2Event_count++] = { TEXT("Beep"), &eventBeep };
Text2Event[Text2Event_count++] = { TEXT("UserDisplayModeForce"), &eventUserDisplayModeForce };
Text2Event[Text2Event_count++] = { TEXT("AirspaceDisplayMode"), &eventAirspaceDisplayMode };
Text2Event[Text2Event_count++] = { TEXT("AutoLogger"), &eventAutoLogger };
Text2Event[Text2Event_count++] = { TEXT("MyMenu"), &eventMyMenu };
Text2Event[Text2Event_count++] = { TEXT("AddWaypoint"), &eventAddWaypoint };
Text2Event[Text2Event_count++] = { TEXT("Orientation"), &eventOrientation };
Text2Event[Text2Event_count++] = { TEXT("CalcWind"), &eventCalcWind };
Text2Event[Text2Event_count++] = { TEXT("InvertColor"), &eventInvertColor };
Text2Event[Text2Event_count++] = { TEXT("ChangeBack"), &eventChangeBack };
Text2Event[Text2Event_count++] = { TEXT("ResetTask"), &eventResetTask };
Text2Event[Text2Event_count++] = { TEXT("ResetQFE"), &eventResetQFE };
Text2Event[Text2Event_count++] = { TEXT("RestartCommPorts"), &eventRestartCommPorts };
Text2Event[Text2Event_count++] = { TEXT("MoveGlider"), &eventMoveGlider };
Text2Event[Text2Event_count++] = { TEXT("ActiveMap"), &eventActiveMap };
Text2Event[Text2Event_count++] = { TEXT("ChangeWindCalcSpeed"), &eventChangeWindCalcSpeed };
Text2Event[Text2Event_count++] = { TEXT("TimeGates"), &eventTimeGates };
Text2Event[Text2Event_count++] = { TEXT("ChangeMultitarget"), &eventChangeMultitarget };
Text2Event[Text2Event_count++] = { TEXT("BaroAltitude"), &eventBaroAltitude };
Text2Event[Text2Event_count++] = { TEXT("ChangeHGPS"), &eventChangeHGPS };
Text2Event[Text2Event_count++] = { TEXT("ChangeGS"), &eventChangeGS };
Text2Event[Text2Event_count++] = { TEXT("ChangeTurn"), &eventChangeTurn };
Text2Event[Text2Event_count++] = { TEXT("Service"), &eventService };
Text2Event[Text2Event_count++] = { TEXT("MinimapKey"), &eventMinimapKey };
Text2Event[Text2Event_count++] = { TEXT("InfoStripe"), &eventInfoStripe };
Text2Event[Text2Event_count++] = { TEXT("InfoPage"), &eventInfoPage };
Text2Event[Text2Event_count++] = { TEXT("ModeType"), &eventModeType };
Text2Event[Text2Event_count++] = { TEXT("ShowMultiselect"), &eventShowMultiselect };
Text2Event[Text2Event_count++] = { TEXT("ChangeNettoVario"), &eventChangeNettoVario };
assert(Text2Event_count < array_size(Text2Event));


memset(Text2GCE, 0, sizeof(Text2GCE));
Text2GCE[GCE_COMMPORT_RESTART] = TEXT("COMMPORT_RESTART");
Text2GCE[GCE_FLARM_NOTRAFFIC] = TEXT("FLARM_NOTRAFFIC");
Text2GCE[GCE_FLARM_TRAFFIC] = TEXT("FLARM_TRAFFIC");
Text2GCE[GCE_FLIGHTMODE_CLIMB] = TEXT("FLIGHTMODE_CLIMB");
Text2GCE[GCE_FLIGHTMODE_CRUISE] = TEXT("FLIGHTMODE_CRUISE");
Text2GCE[GCE_FLIGHTMODE_FINALGLIDE] = TEXT("FLIGHTMODE_FINALGLIDE");
Text2GCE[GCE_FLIGHTMODE_FINALGLIDE_TERRAIN] = TEXT("FLIGHTMODE_FINALGLIDE_TERRAIN");
Text2GCE[GCE_FLIGHTMODE_FINALGLIDE_ABOVE] = TEXT("FLIGHTMODE_FINALGLIDE_ABOVE");
Text2GCE[GCE_FLIGHTMODE_FINALGLIDE_BELOW] = TEXT("FLIGHTMODE_FINALGLIDE_BELOW");
Text2GCE[GCE_LANDING] = TEXT("LANDING");
Text2GCE[GCE_STARTUP_REAL] = TEXT("STARTUP_REAL");
Text2GCE[GCE_STARTUP_SIMULATOR] = TEXT("STARTUP_SIMULATOR");
Text2GCE[GCE_TAKEOFF] = TEXT("TAKEOFF");
Text2GCE[GCE_TASK_NEXTWAYPOINT] = TEXT("TASK_NEXTWAYPOINT");
Text2GCE[GCE_TASK_START] = TEXT("TASK_START");
Text2GCE[GCE_TASK_FINISH] = TEXT("TASK_FINISH");
Text2GCE[GCE_TEAM_POS_REACHED] = TEXT("TEAM_POS_REACHED");
Text2GCE[GCE_ARM_READY] = TEXT("ARM_READY");
Text2GCE[GCE_TASK_CONFIRMSTART] = TEXT("TASK_CONFIRMSTART");
Text2GCE[GCE_POPUP_MULTISELECT] = TEXT("POPUP_MULTISELECT");
Text2GCE[GCE_WAYPOINT_DETAILS_SCREEN] = TEXT("WAYPOINT_DETAILS_SCREEN");
// Add new Event here ...
Text2GCE[GCE_COUNT] = TEXT("COUNT");
// Check for missing item
assert(std::find(std::begin(Text2GCE), std::end(Text2GCE), nullptr) == std::end(Text2GCE));
// Check for array overrun
static_assert(GCE_COUNT < array_size(Text2GCE), "invalid Text2GCE array size"); 


Text2NE[NE_COUNT] = TEXT("COUNT");
// Check for missing item
assert(std::find(std::begin(Text2NE), std::end(Text2NE), nullptr) == std::end(Text2NE));
// Check no array overrun
static_assert(NE_COUNT < array_size(Text2NE), "invalid Text2NE array size");

