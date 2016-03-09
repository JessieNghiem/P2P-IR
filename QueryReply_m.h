//
// Generated file, do not edit! Created by nedtool 4.6 from QueryReply.msg.
//

#ifndef _QUERYREPLY_M_H_
#define _QUERYREPLY_M_H_

#include <omnetpp.h>

// nedtool version check
#define MSGC_VERSION 0x0406
#if (MSGC_VERSION!=OMNETPP_VERSION)
#    error Version mismatch! Probably this file was generated by an earlier version of nedtool: 'make clean' should help.
#endif



// cplusplus {{
#include <vector>
#include "ApplPkt_m.h"
#include "QueryReplyMessage.h"
typedef std::vector<QueryReplyMessage> vecQueryReply;
// }}

/**
 * Class generated from <tt>QueryReply.msg:29</tt> by nedtool.
 * <pre>
 * //
 * // TODO generated message class
 * //
 * packet QueryReply extends ApplPkt
 * {
 *     vecQueryReply replyBusinesses;	// The result of the reply businesses
 *     simtime_t timeStamp;	// Time stamp
 * }
 * </pre>
 */
class QueryReply : public ::ApplPkt
{
  protected:
    vecQueryReply replyBusinesses_var;
    simtime_t timeStamp_var;

  private:
    void copy(const QueryReply& other);

  protected:
    // protected and unimplemented operator==(), to prevent accidental usage
    bool operator==(const QueryReply&);

  public:
    QueryReply(const char *name=NULL, int kind=0);
    QueryReply(const QueryReply& other);
    virtual ~QueryReply();
    QueryReply& operator=(const QueryReply& other);
    virtual QueryReply *dup() const {return new QueryReply(*this);}
    virtual void parsimPack(cCommBuffer *b);
    virtual void parsimUnpack(cCommBuffer *b);

    // field getter/setter methods
    virtual vecQueryReply& getReplyBusinesses();
    virtual const vecQueryReply& getReplyBusinesses() const {return const_cast<QueryReply*>(this)->getReplyBusinesses();}
    virtual void setReplyBusinesses(const vecQueryReply& replyBusinesses);
    virtual simtime_t getTimeStamp() const;
    virtual void setTimeStamp(simtime_t timeStamp);
};

inline void doPacking(cCommBuffer *b, QueryReply& obj) {obj.parsimPack(b);}
inline void doUnpacking(cCommBuffer *b, QueryReply& obj) {obj.parsimUnpack(b);}


#endif // ifndef _QUERYREPLY_M_H_

