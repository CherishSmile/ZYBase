//
//  TestTableViewCell.swift
//  BaseDemo
//
//  Created by Mzywx on 2016/12/23.
//  Copyright © 2016年 Mzywx. All rights reserved.
//

import UIKit
import ZYBase
import SnapKit

typealias ExpendClosure = () -> ()

class TestTableViewCell: UITableViewCell {

    
    fileprivate var btn:UIButton!
    fileprivate var lbl:UILabel!
    var expendSure : ExpendClosure?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatSubviews()
    }
    
    
    func creatSubviews()  {
        btn = creatButton("点击操作", .system)
        drowBorder(btn, .cyan, 6.0)
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.contentView.addSubview(btn)
        
        lbl = creatLable(getFont(14), text: nil)
        lbl.numberOfLines = 0
        lbl.backgroundColor = .brown
        drowBorder(lbl, .blue, 6.0)
        self.contentView.addSubview(lbl)
        lbl.preferredMaxLayoutWidth = SCREEN_WIDTH-20
        
        btn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        lbl.snp.makeConstraints { (make) in
            make.left.right.equalTo(btn)
            make.top.equalTo(btn.snp.bottom).offset(10)
        }
        
        setAutoCellHeightCondition(self, lbl, 10)
        
    }
    
    func configData(model:TestModel)  {
        btn.setTitle(model.isExpend! ? "合并" : "展开", for: .normal)
        lbl.text = model.content
        lbl.backgroundColor = model.isExpend! ? .brown : .orange
        btn.backgroundColor = model.isExpend! ? .orange : .brown
    }
    
    func btnClick() {
        if expendSure != nil {
            expendSure!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
