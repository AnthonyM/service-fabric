// ------------------------------------------------------------
// Copyright (c) Microsoft Corporation.  All rights reserved.
// Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

#include "stdafx.h"

using namespace std;
using namespace Common;
using namespace Hosting2;

DeactivateCodePackageReply::DeactivateCodePackageReply() 
    : errorCode_()
{
}

DeactivateCodePackageReply::DeactivateCodePackageReply(
    ErrorCode const & errorCode)
    : errorCode_(errorCode)
{
}

void DeactivateCodePackageReply::WriteTo(TextWriter & w, FormatOptions const &) const
{
    w.Write("DeactivateCodePackageReply { ");
    w.Write("ErrorCode = {0}", Error);
    w.Write("}");
}
