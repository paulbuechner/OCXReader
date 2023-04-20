/***************************************************************************
 *   Created on: 30 Nov 2022                                               *
 ***************************************************************************
 *   Copyright (c) 2022, Carsten Zerbst (carsten.zerbst@groy-groy.de)      *
 *   Copyright (c) 2022, Paul Buechner                                     *
 *                                                                         *
 *   This file is part of the OCXReader library.                           *
 *                                                                         *
 *   This library is free software; you can redistribute it and/or         *
 *   modify it under the terms of the GNU Lesser General Public License    *
 *   version 2.1 as published by the Free Software Foundation.             *
 *                                                                         *
 ***************************************************************************/

// This file #includes all shipxml implementation .cc files. The
// purpose is to allow a user to build shipxml by compiling this
// file alone.

// The following lines pull in the real shipxml*.cc files.

#include "reader/shipxml-coordinate-system-reader.cc"
#include "reader/shipxml-curve-reader.cc"
#include "reader/shipxml-panel-reader.cc"
#include "reader/shipxml-plate-reader.cc"
#include "shipxml-driver.cc"
#include "shipxml-helper.cc"
#include "shipxml-log.cc"
#include "shipxml-ship-steel-transfer.cc"
#include "xml_entities/shipxml-am-curve.cc"
#include "xml_entities/shipxml-arc-segment.cc"
#include "xml_entities/shipxml-cartesian-point.cc"
#include "xml_entities/shipxml-entity-with-properties.cc"
#include "xml_entities/shipxml-enums.cc"
#include "xml_entities/shipxml-extrusion.cc"
#include "xml_entities/shipxml-generel-data.cc"
#include "xml_entities/shipxml-key-value.cc"
#include "xml_entities/shipxml-limit.cc"
#include "xml_entities/shipxml-named-entity.cc"
#include "xml_entities/shipxml-panel.cc"
#include "xml_entities/shipxml-plate.cc"
#include "xml_entities/shipxml-properties.cc"
#include "xml_entities/shipxml-structure.cc"
#include "xml_entities/shipxml-support.cc"
#include "xml_entities/shipxml-vector.cc"
