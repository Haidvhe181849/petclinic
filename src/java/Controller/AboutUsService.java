/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author trung123
 */
import DAO.AboutUsDAO;
import Entity.AboutUs;
import java.util.List;


    
class AboutUsService {
        AboutUsDAO dao = new AboutUsDAO();


    public List<AboutUs> getAll() {
        return dao.getAll();
    }

    public void insert(AboutUs about) {
        dao.insert(about);
    }

    public void update(AboutUs about) {
        dao.update(about);
    }

    public void delete(int id) {
        dao.delete(id);
    }

}
