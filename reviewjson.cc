/*
 * reviewjson.cc
 *
 *  Created on: Mar 23, 2016
 *      Author: jessie
 */

#include <reviewjson.h>

Register_Class(reviewjson)

reviewjson::reviewjson() {}

reviewjson::reviewjson(const Json::Value r) {
    // TODO Auto-generated constructor stub
    root = r;
    //pCoord = p;
}

reviewjson::reviewjson(const reviewjson *other) {
    // TODO Auto-generated constructor stub
    this->root = other->getRoot();
    //this->pCoord = other->getPCoord();
}

reviewjson::reviewjson(const reviewjson& other) {
    // TODO Auto-generated constructor stub
    operator=(other);
}

reviewjson::~reviewjson() {
    // TODO Auto-generated destructor stub
}

Json::Value reviewjson::getRoot() const {
    return root;
}

void reviewjson::setRoot(Json::Value r) {
    root = r;
}

/*Coord reviewjson::getPCoord() const {
    return pCoord;
}

void reviewjson::setPCoord(Coord p) {
    pCoord = p;
}*/

reviewjson& reviewjson::operator=(const reviewjson& other) {
    if (&other==this) return *this;
    root = other.getRoot();
    //pCoord = other.getPCoord();
    return *this;
}

reviewjson* reviewjson::dup() const
{
    return new reviewjson(*this);
}
