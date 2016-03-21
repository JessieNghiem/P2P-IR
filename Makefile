#
# OMNeT++/OMNEST Makefile for P2PIR
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -I/home/jessie/Downloads/MiXiM/src/base/phyLayer -I/home/jessie/Downloads/MiXiM/src/base/modules -I/home/jessie/Downloads/MiXiM/src/inet_stub/mobility -I/home/jessie/Downloads/MiXiM/src/inet_stub/util -I/home/jessie/Downloads/MiXiM/src/inet_stub/linklayer/contract -I/home/jessie/Downloads/MiXiM/src/base/connectionManager -I/home/jessie/Downloads/MiXiM/src/inet_stub/networklayer/common -I/home/jessie/Downloads/MiXiM/src -I/home/jessie/Downloads/MiXiM/src/inet_stub/base -I/home/jessie/Downloads/MiXiM/src/base/messages -I/home/jessie/Downloads/MiXiM/src/base/utils -I/home/jessie/Downloads/MiXiM/src/base -I/home/jessie/Downloads/MiXiM/src/inet_stub/mobility/models -L/home/jessie/Downloads/MiXiM/out/$$\(CONFIGNAME\)/src -lmixim -KMIXIM_PROJ=/home/jessie/Downloads/MiXiM
#

# Name of target to be created (-o option)
TARGET = P2PIR$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I$(MIXIM_PROJ)/src/base/phyLayer \
    -I$(MIXIM_PROJ)/src/base/modules \
    -I$(MIXIM_PROJ)/src/inet_stub/mobility \
    -I$(MIXIM_PROJ)/src/inet_stub/util \
    -I$(MIXIM_PROJ)/src/inet_stub/linklayer/contract \
    -I$(MIXIM_PROJ)/src/base/connectionManager \
    -I$(MIXIM_PROJ)/src/inet_stub/networklayer/common \
    -I$(MIXIM_PROJ)/src \
    -I$(MIXIM_PROJ)/src/inet_stub/base \
    -I$(MIXIM_PROJ)/src/base/messages \
    -I$(MIXIM_PROJ)/src/base/utils \
    -I$(MIXIM_PROJ)/src/base \
    -I$(MIXIM_PROJ)/src/inet_stub/mobility/models \
    -I. \
    -IMAIN_INDEXING_PATH0 \
    -IMAIN_INDEXING_PATH1 \
    -IQueryResults \
    -IQueryResults/0 \
    -IQueryResults/1 \
    -Iinput \
    -Iinput/datafile \
    -Iinput/index \
    -Iinput/index/0 \
    -Iinput/index/1 \
    -Ijson \
    -Iresults

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L$(MIXIM_PROJ)/out/$(CONFIGNAME)/src  -lmixim
LIBS += -Wl,-rpath,`abspath $(MIXIM_PROJ)/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc and .msg files
OBJS = \
    $O/Util.o \
    $O/IndexDataset.o \
    $O/ExtractDataset.o \
    $O/jsoncpp.o \
    $O/QueryScore.o \
    $O/MyApplicationLayer.o \
    $O/Query.o \
    $O/ReadDataset.o \
    $O/BeaconReply_m.o \
    $O/QueryReply_m.o \
    $O/Beacon_m.o \
    $O/Query_m.o

# Message files
MSGFILES = \
    BeaconReply.msg \
    QueryReply.msg \
    Beacon.msg \
    Query.msg

# Other makefile variables (-K)
MIXIM_PROJ=/home/jessie/Downloads/MiXiM

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppmain$D $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS)  $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating executable: $@
	$(Q)$(CXX) $(LDFLAGS) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS)

.PHONY: all clean cleanall depend msgheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f P2PIR P2PIR.exe libP2PIR.so libP2PIR.a libP2PIR.dll libP2PIR.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h
	$(Q)-rm -f MAIN_INDEXING_PATH0/*_m.cc MAIN_INDEXING_PATH0/*_m.h
	$(Q)-rm -f MAIN_INDEXING_PATH1/*_m.cc MAIN_INDEXING_PATH1/*_m.h
	$(Q)-rm -f QueryResults/*_m.cc QueryResults/*_m.h
	$(Q)-rm -f QueryResults/0/*_m.cc QueryResults/0/*_m.h
	$(Q)-rm -f QueryResults/1/*_m.cc QueryResults/1/*_m.h
	$(Q)-rm -f input/*_m.cc input/*_m.h
	$(Q)-rm -f input/datafile/*_m.cc input/datafile/*_m.h
	$(Q)-rm -f input/index/*_m.cc input/index/*_m.h
	$(Q)-rm -f input/index/0/*_m.cc input/index/0/*_m.h
	$(Q)-rm -f input/index/1/*_m.cc input/index/1/*_m.h
	$(Q)-rm -f json/*_m.cc json/*_m.h
	$(Q)-rm -f results/*_m.cc results/*_m.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES)  ./*.cc MAIN_INDEXING_PATH0/*.cc MAIN_INDEXING_PATH1/*.cc QueryResults/*.cc QueryResults/0/*.cc QueryResults/1/*.cc input/*.cc input/datafile/*.cc input/index/*.cc input/index/0/*.cc input/index/1/*.cc json/*.cc results/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/BeaconReply_m.o: BeaconReply_m.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	BeaconReply_m.h
$O/Beacon_m.o: Beacon_m.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	Beacon_m.h
$O/ExtractDataset.o: ExtractDataset.cc \
	Business.h \
	ExtractDataset.h \
	json/json.h
$O/IndexDataset.o: IndexDataset.cc \
	CollectionFrequency.h \
	Document.h \
	Index.h \
	IndexDataset.h \
	Lexicon.h \
	json/json.h
$O/MyApplicationLayer.o: MyApplicationLayer.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/modules/AddressingInterface.h \
	$(MIXIM_PROJ)/src/base/modules/BaseApplLayer.h \
	$(MIXIM_PROJ)/src/base/modules/BaseBattery.h \
	$(MIXIM_PROJ)/src/base/modules/BaseLayer.h \
	$(MIXIM_PROJ)/src/base/modules/BaseModule.h \
	$(MIXIM_PROJ)/src/base/modules/MiximBatteryAccess.h \
	$(MIXIM_PROJ)/src/base/utils/FindModule.h \
	$(MIXIM_PROJ)/src/base/utils/HostState.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/NetwControlInfo.h \
	$(MIXIM_PROJ)/src/base/utils/PassedMessage.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/BasicModule.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INotifiable.h \
	$(MIXIM_PROJ)/src/inet_stub/base/ModuleAccess.h \
	$(MIXIM_PROJ)/src/inet_stub/base/NotificationBoard.h \
	$(MIXIM_PROJ)/src/inet_stub/base/NotifierConsts.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/IMobility.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/LinearMobility.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/MobilityBase.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/MovingMobilityBase.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	BeaconReply_m.h \
	Beacon_m.h \
	Business.h \
	CollectionFrequency.h \
	Constant.h \
	Document.h \
	ExtractDataset.h \
	Index.h \
	IndexDataset.h \
	KeyWords.h \
	Lexicon.h \
	MyApplicationLayer.h \
	QueryReplyMessage.h \
	QueryReply_m.h \
	QueryScore.h \
	Query_m.h \
	Util.h \
	json/json.h
$O/Query.o: Query.cc \
	CollectionFrequency.h \
	Document.h \
	Lexicon.h \
	json/json.h
$O/QueryReply_m.o: QueryReply_m.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	QueryReplyMessage.h \
	QueryReply_m.h
$O/QueryScore.o: QueryScore.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/modules/BaseApplLayer.h \
	$(MIXIM_PROJ)/src/base/modules/BaseBattery.h \
	$(MIXIM_PROJ)/src/base/modules/BaseLayer.h \
	$(MIXIM_PROJ)/src/base/modules/BaseModule.h \
	$(MIXIM_PROJ)/src/base/modules/MiximBatteryAccess.h \
	$(MIXIM_PROJ)/src/base/utils/HostState.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/PassedMessage.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/BasicModule.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INotifiable.h \
	$(MIXIM_PROJ)/src/inet_stub/base/ModuleAccess.h \
	$(MIXIM_PROJ)/src/inet_stub/base/NotificationBoard.h \
	$(MIXIM_PROJ)/src/inet_stub/base/NotifierConsts.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/IMobility.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/LinearMobility.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/MobilityBase.h \
	$(MIXIM_PROJ)/src/inet_stub/mobility/models/MovingMobilityBase.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	BeaconReply_m.h \
	Beacon_m.h \
	CollectionFrequency.h \
	Constant.h \
	Document.h \
	KeyWords.h \
	Lexicon.h \
	MyApplicationLayer.h \
	QueryReplyMessage.h \
	QueryReply_m.h \
	QueryScore.h \
	Query_m.h \
	json/json.h
$O/Query_m.o: Query_m.cc \
	$(MIXIM_PROJ)/src/base/messages/ApplPkt_m.h \
	$(MIXIM_PROJ)/src/base/utils/MiXiMDefs.h \
	$(MIXIM_PROJ)/src/base/utils/SimpleAddress.h \
	$(MIXIM_PROJ)/src/base/utils/miximkerneldefs.h \
	$(MIXIM_PROJ)/src/inet_stub/base/Coord.h \
	$(MIXIM_PROJ)/src/inet_stub/base/INETDefs.h \
	$(MIXIM_PROJ)/src/inet_stub/linklayer/contract/MACAddress.h \
	$(MIXIM_PROJ)/src/inet_stub/util/FWMath.h \
	KeyWords.h \
	Query_m.h
$O/ReadDataset.o: ReadDataset.cc \
	Business.h \
	ExtractDataset.h \
	json/json.h
$O/Util.o: Util.cc \
	Util.h
$O/jsoncpp.o: jsoncpp.cc \
	json/json.h

