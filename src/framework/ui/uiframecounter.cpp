/*
 * Copyright (c) 2010-2011 OTClient <https://github.com/edubart/otclient>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "uiframecounter.h"
#include <framework/graphics/font.h>
#include <framework/otml/otmlnode.h>
#include <framework/platform/platform.h>
#include <framework/graphics/graphics.h>

void UIFrameCounter::setup()
{
    UIWidget::setup();
    setFocusable(false);
    setPhantom(true);
    setAlign(Fw::AlignLeft);
    m_lastFrameTicks = g_platform.getTicks();
    m_frameCount = 0;
}

void UIFrameCounter::render()
{
    UIWidget::render();

    int now = g_platform.getTicks();
    if(now - m_lastFrameTicks >= 1000) {
        m_fpsText = Fw::mkstr("FPS: ", m_frameCount);
        m_lastFrameTicks = now;
        m_frameCount = 0;
    } else
        m_frameCount++;

    m_font->renderText(m_fpsText, m_rect, m_align, Fw::white);
}

void UIFrameCounter::onStyleApply(const OTMLNodePtr& styleNode)
{
    UIWidget::onStyleApply(styleNode);

    for(const OTMLNodePtr& node : styleNode->children()) {
        if(node->tag() == "align")
            setAlign(Fw::translateAlignment(node->value()));
    }
}