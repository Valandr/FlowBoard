class ChangeSkillLevelToIntegerInFigures < ActiveRecord::Migration[8.0]
  def up
    # Étape 1 : Ajouter une nouvelle colonne temporaire en integer
    add_column :figures, :skill_level_int, :integer

    # Étape 2 : Convertir les valeurs string en integer
    Figure.reset_column_information
    Figure.find_each do |figure|
      case figure.skill_level
      when 'beginner'
        figure.update_column(:skill_level_int, 0)
      when 'intermediate'
        figure.update_column(:skill_level_int, 1)
      when 'advanced'
        figure.update_column(:skill_level_int, 2)
      else
        figure.update_column(:skill_level_int, 0) # Valeur par défaut
      end
    end

    # Étape 3 : Supprimer l'ancienne colonne et renommer la nouvelle
    remove_column :figures, :skill_level
    rename_column :figures, :skill_level_int, :skill_level
  end

  def down
    # Étape 1 : Ajouter une colonne temporaire string
    add_column :figures, :skill_level_str, :string

    # Étape 2 : Convertir integer → string
    Figure.reset_column_information
    Figure.find_each do |figure|
      case figure.skill_level
      when 0
        figure.update_column(:skill_level_str, 'beginner')
      when 1
        figure.update_column(:skill_level_str, 'intermediate')
      when 2
        figure.update_column(:skill_level_str, 'advanced')
      else
        figure.update_column(:skill_level_str, 'beginner') # Valeur par défaut
      end
    end

    # Étape 3 : Supprimer l'ancienne colonne et renommer
    remove_column :figures, :skill_level
    rename_column :figures, :skill_level_str, :skill_level
  end
end
