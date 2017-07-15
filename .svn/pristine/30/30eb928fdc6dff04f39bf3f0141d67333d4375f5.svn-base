//
//  TestAlertView.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/22.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import ZYBase

class TestAlertView: UIView {

    func creatAlertView() {
        drawBorder(self, .gray, 3.0)
        self.backgroundColor = .white
        let marllbl = creatLable(getFont(14), "继承BaseAlertView，创建你想要的alert")
        marllbl.frame = .init(x: 0, y: 0, width: VIEW_WIDTH(self), height: VIEW_HEIGHT(self))
        marllbl.center = self.center
        marllbl.textAlignment = .center
        self.addSubview(marllbl)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        creatAlertView()
    }
    func show() {
        showZYAlert(.fade, false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
