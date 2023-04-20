/***************************************************************************
 *   Created on: 03 Nov 2022                                               *
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

// This file #includes all ocx implementation .cc files. The
// purpose is to allow a user to build ocx by compiling this
// file alone.

// The following lines pull in the real ocx*.cc files.

// General
#include "ocx-context.cc"
#include "ocx-helper.cc"
#include "ocx-log.cc"
#include "ocx-reader.cc"
#include "ocx-utils.cc"

//-----------------------------------------------------------------------------
// Context Entities
//-----------------------------------------------------------------------------

#include "context_entities/ocx-bar-section.cc"
#include "context_entities/ocx-principal-particulars-wrapper.cc"
#include "context_entities/ocx-refplane-wrapper.cc"
#include "context_entities/ocx-vessel-grid-wrapper.cc"

//-----------------------------------------------------------------------------
// Reader
//-----------------------------------------------------------------------------

#include "reader/shared/ocx-curve.cc"
#include "reader/shared/ocx-cut-by.cc"
#include "reader/shared/ocx-limited-by.cc"
#include "reader/shared/ocx-outer-contour.cc"
#include "reader/shared/ocx-surface.cc"
#include "reader/shared/ocx-unbounded-geometry.cc"

// <ocx:ocxXML>
//    <ocx:ClassCatalogue>
#include "reader/class_catalogue/hole_catalogue/ocx-hole-catalogue.cc"
#include "reader/class_catalogue/ocx-class-catalogue.cc"
#include "reader/class_catalogue/x_section_catalogue/ocx-x-section-catalogue.cc"
//    </ocx:ClassCatalogue>
//    <ocx:Vessel>
#include "reader/vessel/ocx-vessel.cc"
//      <ocx:ClassificationData>
#include "reader/vessel/classification_data/ocx-classification-data.cc"
//      </ocx:ClassificationData>
//      <ocx:CoordinateSystem>
#include "reader/vessel/coordinate_system/ocx-coordinate-system.cc"
//      </ocx:CoordinateSystem>
//      <ocx:Panel>
#include "reader/vessel/panel/composed_of/ocx-composed-of.cc"
#include "reader/vessel/panel/ocx-panel.cc"
#include "reader/vessel/panel/stiffened_by/ocx-stiffened-by.cc"
//      </ocx:Panel>
//      <ocx:ReferenceSurfaces>
#include "reader/vessel/reference_surfaces/ocx-reference-surfaces.cc"
//      </ocx:ReferenceSurfaces>
//    </ocx:Vessel>
// </ocx:ocxXML>
