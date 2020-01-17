import UIKit

class RepositoryTableViewCell: UITableViewCell {
   
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for repository: Repository) {
        numberOfStarsLabel.text = String(repository.stars)
        nameLabel.text = repository.name
    }

}
